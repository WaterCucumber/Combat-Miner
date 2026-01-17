@tool
extends TextureRect
class_name AnimatedTextureRect

# Signals
# Enums
# Consts
# Static vars
# Public vars
# Export vars
@export var start_anim_name : String = "default"
@export var sprite_frames : SpriteFrames
@warning_ignore("unused_private_class_variable")
@export_tool_button("Play first animation") var _play_anim_callable : Callable = _test_first
# Onready vars
# Private vars
var _playing := false
var _loop := false
var _frames := 0
var _fps := 0.0

var _timer := 0.0
var _idx := 0
var _anim : String

# Funcs
#region Public funcs

func play_default():
	play(start_anim_name)


func play(anim: String):
	_loop = sprite_frames.get_animation_loop(anim)
	_frames = sprite_frames.get_frame_count(anim)
	_fps = sprite_frames.get_animation_speed(anim)

	_idx = 0
	_timer = 0
	_anim = anim

	_playing = true

#endregion

#region Private funcs

func _play_frame():
	# Check for loop
	if _idx >= _frames:
		if not _loop:
			_playing = false
			return
		else:
			_idx = 0

	# Get duration and set it to the timer
	var duration = sprite_frames.get_frame_duration(_anim, _idx) / _fps
	_timer = duration

	# Get frame and set it to the texture
	var tex = sprite_frames.get_frame_texture(_anim, _idx)
	texture = tex

	# Increase index
	_idx += 1


func _test_first():
	if Engine.is_editor_hint():
		var names := sprite_frames.get_animation_names()
		if not names.is_empty():
			play(names[0])

#endregion

#region Godot funcs

func _ready() -> void:
	if start_anim_name.is_empty(): return
	play(start_anim_name)


func _process(delta: float) -> void:
	if not _playing: 
		return

	if _timer <= 0:
		_play_frame()
	else:
		_timer -= delta

#endregion

#region Signal funcs

#endregion
