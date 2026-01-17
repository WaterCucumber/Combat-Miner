@tool
extends Node2D
class_name CircleCreator

@export var circle_radius : float
@export var snap : float = 16
@export var create_on_ready : bool
@export var draw_result : bool
@export_group("Draw")
@export var color : Color
@export var filled : bool
@export_tool_button("Create Circle") var create_circle_callable := create_circle
@export_tool_button("Redraw") var redraw_callable := queue_redraw

@export var local_points : PackedVector2Array = []
var global_points : PackedVector2Array = []


func create_circle():
	local_points.clear()
	if circle_radius <= 0:
		printerr("Radius can't be negative or 0!")
		circle_radius = 1
	# Step 1: initialize circle local_points
	var points_count = 6 * ceil(circle_radius) + 18 / circle_radius
	_create_points(circle_radius, points_count)
	# Step 2: add offset to local_points
	var offset = circle_radius / 2
	var offset_v2 = Vector2(-offset, offset)
	var offset_count = points_count / 6
	_offset_points(Vector2(-8, 8), offset_count)
	# Step 3: convert to square circle
	_snap_points(snap)
	
	queue_redraw()


func _create_points(radius: float, count : int):
	var step = TAU / count
	for i in range(1, count + 1):
		var angle = i * step
		var vec2 = Vector2.from_angle(angle)
		var point = vec2 * radius
		local_points.append(point)
	if local_points.size() < 5:
		print("Created ", local_points.size(), " local_points.")


func _offset_points(mnmx_offset: Vector2, max_count : int):
	var offset_indexes : PackedInt32Array
	for i in max_count:
		var rnd_index = randi_range(0, local_points.size() - 1)
		if offset_indexes.has(rnd_index): continue
		offset_indexes.append(rnd_index)

	if local_points.size() < 5:
		print("Chosen ", offset_indexes.size(), " local_points.")

	for i in offset_indexes:
		var offset = randf_range(mnmx_offset.x, mnmx_offset.y)
		var half_points_count = ceil(abs(offset))
		if local_points.size() < 5:
			print("\t[%s] " % str(i), " with offset ", offset, 
					"; total local_points: ", half_points_count * 2)
		local_points[i] += local_points[i].direction_to(Vector2.ZERO) * offset
		for j in range(-half_points_count, half_points_count + 1):
			if j != 0:
				var indx = (i + j) % local_points.size()
				var point = local_points[indx]
				if local_points.size() < 5:
					print("\t\t[%s] offset: " % str(j), offset / (abs(j) + 1))
				point += offset / (abs(j) + 1) * point.direction_to(Vector2.ZERO)
				local_points[indx] = point


func _snap_points(snap_size: float):
	for i in local_points.size():
		local_points[i] = ceil(local_points[i] / snap_size) * snap_size
		global_points.append(to_global(local_points[i]))


func _ready() -> void:
	if create_on_ready:
		create_circle()


func _draw() -> void:
	if draw_result:
		var p : PackedVector2Array
		p.append_array(local_points)
		p.append(local_points[0])
		if filled:
			draw_colored_polygon(p, color)
		else:
			draw_polyline(p, color, 0.25)

var t = 1
func _process(delta: float) -> void:
	t -= delta
	if t <= 0:
		t = 0.1
		create_circle()
