extends Camera2D

@export var speed := 900.0

func _process(delta: float) -> void:
	var move_x = Input.get_axis("move_left", "move_right")
	var move_y = Input.get_axis("move_up", "move_down")
	position.x += speed * delta * move_x
	position.y += speed * delta * move_y
	var window_size = Vector2(1152, 648)
	position = position.clamp(window_size - Vector2.ONE * 16, Vector2(limit_right, limit_bottom) - window_size)


func _on_spawn_point_selected() -> void:
	reparent(PlayerInstance)
	position = Vector2.ZERO
	zoom = Vector2.ONE * 4
	set_script(null)
