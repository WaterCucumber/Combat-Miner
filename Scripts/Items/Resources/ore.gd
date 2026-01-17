extends Item
class_name Ore

## When 1 ore uses in craft
@export var abillity_one := ""
## When 2 ores uses in craft
@export var abillity_double := ""
## When all ores places is this
@export var abillity_tripple := ""


func get_abillity(use_count: int) -> String:
	match use_count:
		1:
			return abillity_one
		2:
			return abillity_double
		3:
			return abillity_tripple
	push_error("Count is too big or too small: ", use_count)
	return "N/A " + name


func _to_string() -> String:
	var result = name + " [1: %s\n2: %s\n3: %s]" % [abillity_one, 
			abillity_double, abillity_tripple]
	return result
