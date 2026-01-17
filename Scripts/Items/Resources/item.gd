extends Resource
class_name Item

## Can be null
@export var color : Color
@export var shader_gradient : GradientTexture2D
@export var anim : SpriteFrames
@export var name := ""

func _to_string() -> String:
	return name
