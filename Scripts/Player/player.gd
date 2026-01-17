extends CharacterBody2D
class_name Player

static var instance : Player

var active : bool

@onready var player_inventory: PlayerInventory = $PlayerInventory
@onready var mine_controller: MineController = $MineController


func _init() -> void:
	instance = self


func _on_spawn_point_selected():
	active = true
	reparent(get_tree().root)
