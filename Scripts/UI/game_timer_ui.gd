extends VBoxContainer
class_name GameTimerUi

@onready var label: Label = $Label
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var game_timer: Timer = $GameTimer
@onready var change_scene_button: ChangeSceneButton = $"../Stats/VBoxContainer/ChangeSceneButton"

func _ready() -> void:
	PlayerInstance.player_inventory.inventory_changed.connect(_on_inventory_changed)


func _process(_delta: float) -> void:
	var minutes = floori(game_timer.time_left / 60)
	var seconds = floorf(game_timer.time_left * 100) / 100 - minutes * 60
	label.text = (str(minutes).pad_zeros(2) 
			+ ":" + str(seconds).pad_zeros(2).pad_decimals(2)
			+ " left")
	texture_progress_bar.value = game_timer.time_left / game_timer.wait_time
	modulate = Color.RED.lerp(Color.WHITE, texture_progress_bar.value)


func _on_inventory_changed(inv: Dictionary[Item, int]):
	if inv.keys().size() == 6:
		var tl = game_timer.time_left
		var wt = game_timer.wait_time
		var tt = wt - tl
		var minutes = floori(tt / 60)
		var seconds = floorf(tt * 100) / 100 - minutes * 60
		var time = (str(minutes).pad_zeros(2) 
				+ ":" + str(seconds).pad_zeros(2).pad_decimals(2))
		print("You did it! (%s / %s) (%s seconds)" % [label.text, 
				str(wt), time])
		set_process(false)
		PlayerInstance.active = false
		label.text = "Won in %s!" % time


func _on_game_timer_timeout() -> void:
	set_process(false)
	label.text = "TOO LATE..."
	change_scene_button.pressed.emit()


func _on_spawn_point_selected() -> void:
	game_timer.start()
