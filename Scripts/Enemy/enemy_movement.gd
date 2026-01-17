extends Node
class_name EnemyMovement

# Signals
# Enums
# Consts
const SPEED_MULTIPLIER := 3000.0
# Static vars
# Public vars
# Export vars
@export var speed := 1.0
@export var stop_distance := 1000.0
@export var move_away_distance := 500.0
# Onready vars
@onready var enemy: CharacterBody2D = $".."
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
	var dst = enemy.global_position.distance_squared_to(
				PlayerInstance.global_position)
	var dir_coef : float = int(dst > move_away_distance) * 2.0 - 1.0
	if PlayerInstance.active and (dst > stop_distance or dst < move_away_distance):
		# Get speed factor
		var tile_factor = Map.i.get_custom_data(enemy.global_position, 
				"move_speed_factor") if Map.i else 1.0
		var spd = tile_factor * speed * SPEED_MULTIPLIER

		var dir = enemy.global_position.direction_to(
					PlayerInstance.global_position) * dir_coef
		# Set velocity and play animation
		enemy.velocity = spd * delta * dir
		#animation_controller.play_animation(dir)

		# Apply velocity
		enemy.move_and_slide()

#endregion

#region Signal funcs

#endregion
