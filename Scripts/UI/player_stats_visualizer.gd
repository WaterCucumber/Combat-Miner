extends Node
class_name PlayerStatsVisualizer

# Signals
# Enums
# Consts
# Static vars
# Public vars
# Export vars
# Onready vars
@onready var player_tool: Label = %PlayerTool
@onready var player_inventory: Label = %PlayerInventory
# Private vars
var _player : Player

# Funcs
#region Public funcs

#endregion

#region Virtual funcs

#endregion

#region Private funcs

#endregion

#region Godot funcs

func _ready() -> void:
	_player = PlayerInstance
	_player.player_inventory.inventory_changed.connect(_inventory_changed)
	_player.mine_controller.durability_changed.connect(_durability_changed)
	_inventory_changed(_player.player_inventory.get_inventory())
	_durability_changed(_player.mine_controller.tool_durability)

#endregion

#region Signal funcs

func _inventory_changed(inv: Dictionary[Item, int]):
	var result := "{"
	for i in inv:
		var to_str = i.name
		var r := ""
		var parts = to_str.split(" ")
		for part in parts:
			if part.length() > 4:
				for j in part.length():
					if j % 2 == 0: r += part[j]
			else:
				r += part
			r += " "
		result += r + ": " + str(inv[i]) + ", "
	result = result.trim_prefix(", ") + "}"
	player_inventory.text = result


func _durability_changed(v: int):
	player_tool.text = "Durability: " + str(v)
	player_tool.text += " Damage: " + str(_player.mine_controller.tool_mine_damage)
	player_tool.text += " Hardness: " + str(_player.mine_controller.tool_hardness)

#endregion
