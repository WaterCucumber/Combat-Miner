extends Resource
class_name OreDropTable

## Chance sum must be 1!
@export var values : Dictionary[Item, float]


func get_random_ore() -> Item:
	var cumulative_chance : float = 1
	for i in values.size():
		var chance = values.values()[i]
		if chance > randf_range(0, cumulative_chance):
			return values.keys()[i]
		cumulative_chance -= chance
	return values.keys()[-1]
