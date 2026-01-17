extends Node
class_name PlayerController

# Signals
# Enums
# Consts
# Static vars
# Public vars
# Export vars
# Onready vars
@onready var camera_2d: Camera2D = %Camera2D
# Private vars

# Funcs
#region Public funcs

#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs

func _ready() -> void:
	PlayerInstance.active = true
	PlayerInstance.global_position = Vector2(1600, 900) / 4
	camera_2d.call_deferred("reparent", PlayerInstance)
	await get_tree().process_frame
	camera_2d.position = Vector2.ZERO

#endregion

#region Signal funcs

#endregion
