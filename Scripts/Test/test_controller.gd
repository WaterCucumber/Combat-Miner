extends Node

@onready var map_from_points: TileMapLayer = $"../MapFromPoints"


func _ready() -> void:
	initialize(true)


func initialize(regenerate_circles : bool):
	map_from_points.clear()
	for i in get_children():
		if regenerate_circles:
			i.create_circle()
		map_from_points.create_map(i.global_points)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			for i in get_children():
				i.visible = not i.visible
		elif event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			initialize(true)
		elif event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE:
			get_child(0).create_circle()
			var points = get_child(0).local_points
			for i in get_children():
				i.local_points = points
				i.queue_redraw()
			initialize(false)
