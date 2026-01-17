extends Node
class_name Test

# Public vars
# Export vars
@export var test := false
@export var other_tiles : Array[TileGenerationSettings]
# Onready vars
@onready var map_generation: MapGeneration = $"../MapGeneration"
# Private vars

# Funcs
#region Public funcs

#endregion

#region Private funcs

func _get_noises_range(debug_to_log : bool,
		set_result_to_noises := false, 
		test_size : Vector2 = Vector2.ONE * 100) -> Dictionary:

	var result = {"world": [], "ore": [], "other": []}
	if debug_to_log:
		print("-TYPE------TILE------------------RANGE---------------------\nWorld |")
	result["world"].append_array(_get_range(debug_to_log,
		set_result_to_noises, map_generation.world_generation, test_size))

	if debug_to_log:
		print("Ores  |")
	result["ore"].append_array(_get_range(debug_to_log,
		set_result_to_noises, map_generation.ores_generation, test_size))

	if debug_to_log:
		print("Other |")
	result["other"].append_array(_get_range(debug_to_log,
		set_result_to_noises, other_tiles, test_size))

	return result


func _get_range(debug_to_log : bool,
	set_result_to_noises: bool, arr: Array[TileGenerationSettings], test_size : Vector2) -> Array:
	var result = []
	for tile in arr:
		var min_v = INF
		var max_v = -INF
		# Get min and max noise values for normalization
		# default 100x100 = 10000 is enough
		for x in test_size.x:
			for y in test_size.y:
				var v = tile.noise.get_noise_2d(x, y)
				if v > max_v:
					max_v = v
				elif v < min_v:
					min_v = v
		max_v = roundf(max_v * 1000) / 1000
		min_v = roundf(min_v * 1000) / 1000
		result.append([min_v, max_v])

		var tile_name = str(tile.atlas_pos) if tile.name.is_empty() else tile.name
		var mx = is_equal_approx(tile.max_value, max_v)
		var mn = is_equal_approx(tile.min_value, min_v)
		if debug_to_log and set_result_to_noises and mx and mn:
			# Debug info and continue (to not save)
			print_rich("[color=light_blue]  INFO| %s already mapped" % tile_name)
			continue

		# Debug
		if debug_to_log:
			print("      | ", tile_name, 
					" [%s, %s]" % [str(min_v), str(max_v)])

		# Save resource
		if set_result_to_noises:
			tile.min_value = min_v
			tile.max_value = max_v
			var error : Error = ResourceSaver.save(tile, tile.resource_path)
			if error == OK:
				if debug_to_log:
					print("      | Ресурс успешно сохранён!")
			else:
				print_rich("[color=red] ERROR! Ошибка при сохранении ресурса. ",
						"\n        [b]Error code: '", 
						error, "'.[/b] Resource path: ", tile.resource_path)
	return result

#endregion

#region Godot funcs

func _ready() -> void:
	if not test: return
	var debug_to_log = true
	var save_resources = true
	_get_noises_range(debug_to_log, save_resources)
	if debug_to_log:
		print("-----------------------------------------------------------")

#endregion

#region Signal funcs

#endregion
