@tool
extends AnimatedTextureRect
class_name AnimatedItemTexture

const ALLOY_GRADIENT = preload("uid://c5jd3kpjjvppm")

@onready var animated_item_texture: PanelContainer = $".."

func play_item_anim(item: Item):
	# Set material
	material = ShaderMaterial.new()
	material.shader = ALLOY_GRADIENT
	# Set gradient
	var gradient = item.shader_gradient
	material = material.duplicate(true)
	material.set_shader_parameter("use_gradient", gradient != null)
	material.set_shader_parameter("gradient2D", gradient)
	# Set color
	animated_item_texture.self_modulate = item.color
	# Set animation
	sprite_frames = item.anim
	# Play
	play_default()
