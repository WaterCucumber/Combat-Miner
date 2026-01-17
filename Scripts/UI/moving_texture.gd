extends ColorRect

const SPEED := 0.01

static var tX := 0.5
static var tY := 0.5
static var x_multiplier := 1.0
static var y_multiplier := 1.0
static var count : int = 0

@export var speed_multiplier := 1.0
@onready var moving_texture: ColorRect = $"."
var menu_noise_texture : Texture2D
var shader : ShaderMaterial


func _ready() -> void:
	moving_texture.visibility_changed.connect(_visibility_changed)
	count += 1
	shader = material
	menu_noise_texture = shader.get_shader_parameter("noise")
	shader.set_shader_parameter("noise", menu_noise_texture)


func _process(delta: float) -> void:
	if not visible: 
		return

	tX += x_multiplier * delta * SPEED * speed_multiplier / count
	tY += y_multiplier * delta * SPEED * speed_multiplier / count
	tX = fmod(tX, 1)

	if tX >= 1.0 or tX <= 0.0:
		x_multiplier *= -1

	if tY >= 1.0 or tY <= 0.0:
		y_multiplier *= -1


	shader.set_shader_parameter("offset_x", tX)
	shader.set_shader_parameter("offset_y", tY)


func _visibility_changed():
	count += floori(float(visible) * 2.0 - 1.0)
