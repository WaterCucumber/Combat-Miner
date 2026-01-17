extends Node2D
class_name ItemMovement

signal item_reached_player

const CHASING_DISTANCE := 4 * Map.ONE_TILE_SIZE

@onready var item: ItemInstance = $".."

var reached := false


func _physics_process(delta: float) -> void:
	if item.player.active:
		var dist = item.player.global_position.distance_squared_to(
					global_position)
		if dist <= CHASING_DISTANCE ** 2:
			item.global_position = global_position.move_toward(
						item.player.position, 100 * delta)
			if (not reached 
					and global_position.floor() 
						== item.player.position.floor()):
				item_reached_player.emit()
				reached = true
