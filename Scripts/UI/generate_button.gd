extends Button

@export var menu: Menu

var NOISE = preload("uid://bv7mk45agau41")

var map_seed : float = NAN
var flag := false

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text.is_empty():
		map_seed = randi()
	else:
		map_seed = int(new_text)


func _pressed() -> void:
	disabled = true
	if is_nan(map_seed):
		map_seed = randi()
	seed(int(map_seed))
	print("Map generation seed: ", int(map_seed))
	NOISE.seed = map_seed
	menu.to_scene("res://Scenes/fight.tscn")
