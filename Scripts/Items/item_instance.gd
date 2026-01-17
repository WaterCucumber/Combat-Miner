extends Node2D
class_name ItemInstance

# Signals
# Enums
# Consts
const ITEM_TAKE = preload("res://Assets/Sounds/ItemTake.wav")
# Static vars
# Public vars
var player : Player
# Export vars
@export var item : Item
# Onready vars
@onready var animation: AnimatedSprite2D = $Animation
# Private vars

# Funcs
#region Public funcs

func initialize(new_item: Item):
	item = new_item
	animation.sprite_frames = new_item.anim
	animation.play("default")

#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs

func _ready() -> void:
	player = PlayerInstance

#endregion

#region Signal funcs

func _on_item_reached_player() -> void:
	GlobalAudioPlayer.play_sound(ITEM_TAKE, false, 10)
	player.player_inventory.add_item(item)
	queue_free()

#endregion
