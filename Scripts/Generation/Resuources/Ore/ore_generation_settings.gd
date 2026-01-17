extends TileGenerationSettings
class_name OreGenerationSettings

@export var settings : OreSettings
@export var placeable_tiles : PackedVector2Array
@export var exclude_tiles : PackedVector2Array

func can_place(pos : Vector2) -> bool:
	#region Check zones
	for i in place_zone:
		if not i.can_place(pos): return false
	for i in exclude_zone:
		if i.can_place(pos): return false
	#endregion

	#region Check tiles
	var map = Map.i.world_map
	# Exclude ('OR')
	for i in exclude_tiles:
		if map.get_cell_atlas_coords(pos) == Vector2i(i): return false
	# Must be ('OR')
	var can_place_flag = false
	for i in placeable_tiles:
		if map.get_cell_atlas_coords(pos) == Vector2i(i): 
			can_place_flag = true
			break
	if not can_place_flag:
		return false
	#endregion

	#region Check noise value
	var raw_value : float = noise.get_noise_2dv(pos)
	var normalized_value : float = (raw_value - min_value) / (max_value - min_value)

	# value in [min_threshold, max_threshold)
	var mx = true if max_threshold == 1.001 else normalized_value < max_threshold
	var mn = true if min_threshold == -0.001 else normalized_value >= min_threshold
	#endregion
	return mn and mx
