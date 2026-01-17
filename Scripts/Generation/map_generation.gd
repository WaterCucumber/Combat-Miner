extends Node
class_name MapGeneration

static var instance : MapGeneration

@export var async_generation := false
@export var world_generation : Array[TileGenerationSettings]
@export var ores_generation : Array[TileGenerationSettings]

@onready var map: Map = %Map
var first := true

func _ready() -> void:
	instance = self
	_generate_world_tilemap(async_generation)


func _generate_world_tilemap(async : bool = false):
	var ts := Map.tile_size()
	for x in ts.x:
		# Is x on border
		var is_border_x = x == ts.x - 1 or x == 0
		for y in ts.y:
			var pos : Vector2 = Vector2(x, y)
			# Is x or y on border
			var is_border = (is_border_x or y == ts.y - 1 
					or y == 0)
			if is_border:
				# Create border
				map.world_map.set_cell(pos, 0, Vector2(0, 1))
			else:
				# Set tile
				var tile = _set_tile(pos, world_generation, map.world_map)
				if not tile:
					# If no tile, push error
					push_error("No value at ", pos)
				else:
					_place_ore(pos)

		if async: await get_tree().process_frame


func _place_ore(pos: Vector2):
	# Create tile
	var tile = _set_tile(pos, ores_generation, map.ore_map)

	if tile and tile is OreGenerationSettings:
		# Simplify for map
		map.simple_ore_map.set_cell(pos, 
				0, tile.atlas_pos)

		# Set tile to map dict
		map.set_ore(pos, tile.settings.duplicate())


func _set_tile(pos: Vector2, arr: Array[TileGenerationSettings], 
		tilemap: TileMapLayer) -> TileGenerationSettings:

	var tile : TileGenerationSettings
	for i in arr:
		if i.can_place(pos):
			tile = i
			break

	if tile:
		tilemap.set_cell(pos, 0, tile.atlas_pos)
	return tile
