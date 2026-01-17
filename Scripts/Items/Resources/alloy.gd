extends Item
class_name Alloy

const ALLOY_BASE = preload("uid://bdcg7kp5sayfq")
const ALLOYS = [preload("uid://ksi21v4ompqv"), preload("uid://cgcq7kyddfraq"), preload("uid://bhsqqw0sb2ask")]

enum Level { FIRST, SECOND, THIRD }

## 3 items
@export var composition : Array[Item]
var lvl := Level.FIRST

func initialize(composition_items : Array[Item]):
	composition = composition_items

	# Get Level
	for i in composition:
		if i is Alloy:
			lvl = Level.SECOND
			for j in i.composition:
				if j is Alloy:
					lvl = Level.THIRD
					break
			if lvl == Level.THIRD:
				break

	# Set texture
	anim = SpriteFrames.new()
	anim.add_frame("default", ALLOYS[int(lvl)])

	# Set color
	var cs : PackedColorArray = [
			composition[0].color, 
			composition[1].color, 
			composition[2].color
		]
	color = (cs[0] + cs[1] + cs[2]) / 3

	# Set gradient
	_create_gradient()


func _create_gradient():
	var result := ALLOY_BASE.duplicate(true)
	for i in composition.size():
		var item = composition[i]
		result.gradient.set_color(i, item.color)
	shader_gradient = result


func _to_string() -> String:
	return super._to_string() + " (%s)" % str(composition)


func _init(composition_items : Array[Item]) -> void:
	initialize(composition_items)
