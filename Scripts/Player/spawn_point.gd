extends Node2D
class_name SpawnPointSelector

signal selected
static var instance : SpawnPointSelector

func _init() -> void:
	instance = self
	PlayerInstance.reparent(self)
	PlayerInstance.position = Vector2.ZERO
	selected.connect(
			PlayerInstance._on_spawn_point_selected)


func _physics_process(_delta: float) -> void:
	var mp = get_global_mouse_position()
	global_position = Map.snap_to_map(mp)
	
	var ores := Map.i.ore_map
	var tile_pos = ores.local_to_map(ores.to_local(global_position))
	if ores.get_cell_source_id(tile_pos) != -1:
		modulate = Color.RED
	else:
		modulate = Color.GREEN


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var ores := Map.i.ore_map
			var tile_pos = ores.local_to_map(ores.to_local(global_position))
			if ores.get_cell_source_id(tile_pos) != -1:
				print("Can't place character on ore")
				return
			selected.emit()
			queue_free()
