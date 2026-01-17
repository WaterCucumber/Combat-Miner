extends Control
class_name SpawningUi

@onready var label: Label = $PanelContainer/Label


func _ready() -> void:
	var tile := ""
	show()
	match PlayerInstance.mine_controller.tool_hardness:
		0:
			tile = "brown (copper)"
		1:
			tile = "light gray (iron)"
		2:
			tile = "gray sqr (random)"
		3:
			tile = "blue sqr (hydrotite)"
		4:
			tile = "pink sqr (abyssal)"
		_:
			tile = "any"

	var text := "Click to spawn!\n(suggestion to appear next to %s cells)" % tile
	label.text = text


func _on_spawn_point_selected() -> void:
	queue_free()
