extends Node2D
class_name Map

# Signals
# Enums
# Consts
const ITEM = preload("uid://d0pjrnhgdukwg")

const ONE_TILE_SIZE : int = 16
# Static vars
static var i : Map
# Public vars
# Export vars
@export var size := Vector2(1152, 648) * 4
# Onready vars
@onready var world_map: TileMapLayer = %WorldMap
@onready var ore_map: TileMapLayer = %OreMap
@onready var simple_ore_map: TileMapLayer = %SimpleOreMap
# Private vars
var _ores : Dictionary[Vector2, OreSettings]

# Funcs
#region Public funcs

static func tile_size() -> Vector2i:
	return (Map.i.size / ONE_TILE_SIZE).ceil()


func get_ore(map_pos: Vector2) -> OreSettings:
	return _ores.get(map_pos)


func set_ore(map_pos: Vector2, ore : OreSettings):
	_ores[map_pos] = ore


func damage_ore(map_pos: Vector2, damage: int) -> bool:
	var ore = get_ore(map_pos)

	if ore:
		ore.health -= damage
		if ore.health <= 0:
			_brake_ore(ore, map_pos)

	return ore != null


static func snap_to_map(global_pos: Vector2, centered := true, map_pos := false) -> Vector2:
	var snapped_pos = (global_pos if map_pos else (global_pos / ONE_TILE_SIZE).floor()) * ONE_TILE_SIZE
	if centered:
		snapped_pos += ONE_TILE_SIZE * 0.5 * Vector2.ONE
	return snapped_pos


func get_custom_data(global_pos: Vector2, data_name: String) -> Variant:
	var tile_pos = (global_pos / ONE_TILE_SIZE).floor()
	var data = world_map.get_cell_tile_data(tile_pos)
	if not data:
		push_error("Invalid global position! Can't get tile position at ", global_pos)
		return null
	return data.get_custom_data(data_name)

#endregion

#region Virtual funcs

#endregion

#region Private funcs

func _brake_ore(ore: OreSettings, map_pos: Vector2):
	ore_map.set_cell(map_pos)
	_ores.erase(map_pos)
	var item = ore.containing_ores.get_random_ore()
	if item:
		_create_item(item, map_pos)
	else:
		print("Loser! (Ore is empty)")


func _create_item(type: Item, map_pos: Vector2):
	var item : ItemInstance = ITEM.instantiate()
	add_child(item)
	item.initialize(type)
	item.global_position = snap_to_map(map_pos, true, true)


#endregion

#region Godot funcs

func _init() -> void:
	i = self

#endregion

#region Signal funcs

func _on_spawn_point_selected() -> void:
	ore_map.show()
	simple_ore_map.hide()

#endregion
