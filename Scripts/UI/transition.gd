extends Control
class_name Transition

var MENU_NOISE = preload("uid://xi3wnitv2hdr")
const GRADIENTS = [preload("uid://beo6700hticvs"), 
			preload("uid://vn4mxak68kqd"), 
			preload("uid://cuj7au7eho7qn"), 
			preload("uid://bcassb418dqsm")]
var STREAMS = [preload("uid://ch4i3a5ut6htd"),
			preload("uid://d0isq766dqnx3"), 
			preload("uid://b5u1axd6tij8q"), 
			[
				preload("uid://bhg1onws38f5i"), 
				preload("uid://c638iolqqs5rt")
			].pick_random(), 
		]

@export var change_theme := false
@export var canvas_layer : CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var moving_texture: ColorRect = $MovingTexture


func _ready() -> void:
	show()
	fade_from_load()
	if change_theme:
		var rnd = randi_range(0, 3)
		var stream = STREAMS[rnd]
		MENU_NOISE.seed = randi()
		moving_texture.menu_noise_texture.color_ramp = GRADIENTS[rnd]
		GlobalAudioPlayer.play_music(stream)


func fade_to_scene(scene: String):
	animation_player.play("fade_to_scene")
	await animation_player.animation_finished
	LoadingScreenManager.load_scene(scene, canvas_layer)


func fade_from_load():
	animation_player.play("fade_from_load")
	await animation_player.animation_finished
