extends Node2D
class_name MoveController

# Signals
# Enums
# Consts
const SPEED_MULTIPLIER := 3000
# Static vars
# Public vars
# Export vars
@export var speed := 1.0
@export var decelerate_factor := 1.0
# Onready vars
@onready var animation_controller: AnimationController = $"../AnimatedSprite2D/AnimationController"
@onready var player: Player = $".."
# Private vars

# Funcs
#region Public funcs

#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs


func _physics_process(delta: float) -> void:
	if player.active:
		var direction_x := Input.get_axis("move_left", "move_right")
		var direction_y := Input.get_axis("move_up", "move_down")
		
		# If has input
		# Get speed factor
		var tile_factor = Map.i.get_custom_data(global_position, 
				"move_speed_factor") if Map.i else 1.0
		var spd = tile_factor * speed * SPEED_MULTIPLIER
		if direction_x or direction_y:
			# Input direction
			var dir = Vector2(direction_x, direction_y) * (
						0.75 if direction_x and direction_y else 1.0)
			# Set velocity and play animation
			player.velocity = spd * delta * dir
			animation_controller.play_animation(dir)
		else:
			# Decellerate player and play idle animation
			player.velocity = player.velocity.move_toward(Vector2.ZERO,
					delta * decelerate_factor * spd)
			animation_controller.play_animation(Vector2.ZERO)

		# Apply velocity
		player.move_and_slide()

#endregion

#region Signal funcs

#endregion
