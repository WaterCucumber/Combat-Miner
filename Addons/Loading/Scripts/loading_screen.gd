extends Control

const DIGITS = 2
var digits = 10**DIGITS

@onready var top_progress_bar: TextureProgressBar = %TopProgressBar
@onready var bottom_progress_bar: TextureProgressBar = %BottomProgressBar
@onready var progress_label: RichTextLabel = %ProgressLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var packed_scene : PackedScene
var load_started = false

func _ready():
	animation_player.play("set_up_screen")
	await animation_player.animation_finished
	ResourceLoader.load_threaded_request(LoadingScreenManager.next_scene)
	load_started = true


func _process(_delta: float) -> void:
	if !load_started:
		return
		
	var progress : Array = []
	var status = ResourceLoader.load_threaded_get_status(LoadingScreenManager.next_scene, progress)
	
	# Обновляем прогресс только если он доступен
	if progress.size() > 0:
		top_progress_bar.value = progress[0]
		bottom_progress_bar.value = progress[0]
		var str_progress := str(floorf(progress[0] * digits * 100) / digits).pad_decimals(1).pad_zeros(2)
		progress_label.text = "[font_size=32]%s" % str_progress + "%/100.0%"
	
	# Проверяем статус загрузки
	match status:
		ResourceLoader.THREAD_LOAD_LOADED:
			loading_ended()
		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Loading failed!")
			modulate = Color.RED
			set_process(false)
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Loaded invalid resource!")
			modulate = Color.DARK_CYAN
			set_process(false)


func loading_ended():
	load_started = false
	set_process(false)
	top_progress_bar.value = 1
	bottom_progress_bar.value = 1
	progress_label.text = "[font_size=32]Almost Ready"
	
	# Получаем уже загруженный ресурс без блокировки
	packed_scene = ResourceLoader.load_threaded_get(
				LoadingScreenManager.next_scene)
	if packed_scene != null:
		animation_player.play("load_scene")
		await animation_player.animation_finished
		call_deferred("change_scene")


func change_scene():
	get_tree().change_scene_to_packed(packed_scene)
	queue_free()
