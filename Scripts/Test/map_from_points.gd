extends TileMapLayer


func create_map(global_points : PackedVector2Array):
	# Вычисляем границы полигона вручную
	var bounds = calculate_polygon_bounds(global_points)
	var cell_size = tile_set.tile_size
	
	# Перебираем все тайлы в bounding box полигона
	var start_x = int(bounds.position.x / cell_size.x) - 1
	var end_x = int(bounds.end.x / cell_size.x) + 1
	var start_y = int(bounds.position.y / cell_size.y) - 1
	var end_y = int(bounds.end.y / cell_size.y) + 1
	
	for x in range(start_x, end_x + 1):
		for y in range(start_y, end_y + 1):
			var cell_pos = Vector2i(x, y)
			var world_pos = map_to_local(cell_pos)
			
			# Проверяем, находится ли точка внутри полигона
			if Geometry2D.is_point_in_polygon(world_pos, global_points):
				# Заменяем тайл
				set_cell(cell_pos, 0, Vector2.RIGHT)


func calculate_polygon_bounds(polygon: PackedVector2Array) -> Rect2:
	if polygon.size() == 0:
		return Rect2()
	
	var min_point = polygon[0]
	var max_point = polygon[0]
	
	for point in polygon:
		min_point.x = min(min_point.x, point.x)
		min_point.y = min(min_point.y, point.y)
		max_point.x = max(max_point.x, point.x)
		max_point.y = max(max_point.y, point.y)
	
	return Rect2(min_point, max_point - min_point)
