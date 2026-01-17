extends Resource
class_name TileGenerationSettings

@export var name : String
@export var atlas_pos : Vector2
## Greater threshold - less tiles on the map (0 means all tiles is this, 1 means no this tiles)
## -0.001 returns always true
@export_range(-0.001, 1.0, 0.001) var min_threshold : float = 0
## Greater threshold - more tiles on the map (1 means all tiles is this, 0 means no this tiles)
## 1.001 returns always true
@export_range(0.0, 1.001, 0.001) var max_threshold : float = 1.001
@export var noise : Noise
## Value for mapping to [0;1]. You can get it by running test
@export var min_value : float = 0
## Value for mapping to [0;1]. You can get it by running test
@export var max_value : float = 1
## This tile can be placed only at this zone (only if 'AND') and can't be on other positions
@export var place_zone : Array[TileGenerationSettings]
## This tile can't be placed at this zone ('OR')
@export var exclude_zone : Array[TileGenerationSettings]

func can_place(pos : Vector2) -> bool:
	for i in place_zone:
		if not i.can_place(pos): return false
	for i in exclude_zone:
		if i.can_place(pos): return false
	var raw_value : float = noise.get_noise_2dv(pos)
	var normalized_value : float = (raw_value - min_value) / (max_value - min_value)

	# value in [min_threshold, max_threshold)
	var mx = true if max_threshold == 1.001 else normalized_value < max_threshold
	var mn = true if min_threshold == -0.001 else normalized_value >= min_threshold
	return mn and mx
