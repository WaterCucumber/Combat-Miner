extends Node2D
class_name MineController

# Signals
signal durability_changed(value: int)
# Export vars
@export var tile_mine_distance : float = 9
@export var tool_hardness : int = 9
@export var tool_mine_damage : int = 1
@export var tool_durability : int = 1099
# Onready vars
@onready var player: Player = $".."
# Private vars

# Funcs
#region Public funcs

#endregion

#region Private funcs

func _can_mine(pos: Vector2, ore_hardness: float) -> bool:
	var sqr_dist = global_position.distance_squared_to(pos)
	var mine_distance = tile_mine_distance * Map.ONE_TILE_SIZE
	return tool_durability > 0 and ore_hardness <= tool_hardness and sqr_dist <= mine_distance ** 2


func _mine_ore(pos: Vector2, map_pos: Vector2):
	var map_ore = Map.i.get_ore(map_pos)
	if map_ore and _can_mine(pos, map_ore.hardness):
		_damage_ore(map_pos)


func _damage_ore(map_pos: Vector2):
	if Map.i.damage_ore(map_pos, tool_mine_damage):
		tool_durability -= 1
		durability_changed.emit(tool_durability)

#endregion

#region Godot funcs

func _input(event: InputEvent) -> void:
	if not player.active or not Map.i: 
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var mp = get_global_mouse_position()
		var map_pos = (mp / Map.ONE_TILE_SIZE).floor()
		_mine_ore(mp, map_pos)

#endregion
