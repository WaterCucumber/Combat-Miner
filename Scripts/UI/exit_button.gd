extends Button

@export var menu: Menu

func _pressed() -> void:
	await menu.to_scene("")
	get_tree().quit()
