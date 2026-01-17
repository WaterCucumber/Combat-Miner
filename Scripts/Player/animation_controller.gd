extends Node
class_name AnimationController

# Signals
# Enums
# Consts
# Static vars
# Public vars
# Export vars
# Onready vars
@onready var animated_sprite: AnimatedSprite2D = $".."
# Private vars

# Funcs
#region Public funcs

func play_animation(dir: Vector2):
	if dir.y < 0:
		animated_sprite.play("walk_up")
	elif dir.x > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk_right")
	elif dir.y > 0:
		animated_sprite.play("walk_down")
	elif dir.x < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk_right")
	else:
		animated_sprite.play("idle_right")

#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs

#endregion

#region Signal funcs

#endregion
