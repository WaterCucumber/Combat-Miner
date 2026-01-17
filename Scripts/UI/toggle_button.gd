extends Button

@export var to_toggle : Array[CanvasItem]

func _pressed() -> void:
	for i in to_toggle:
		i.visible = not i.visible
