extends Node
class_name PlayerInventory

# Signals
signal inventory_changed(inventory: Dictionary[Item, int])
# Enums
# Consts
# Static vars
static var i : PlayerInventory
# Public vars
# Export vars
@export var _inventory : Dictionary[Item, int] 
# Onready vars
# Private vars

# Funcs
#region Public funcs

func get_inventory() -> Dictionary[Item, int]:
	return _inventory


func add_item(item: Item, count := 1):
	if _inventory.has(item):
		_inventory[item] += count
	else:
		if item is Alloy:
			var item_cols := item.shader_gradient.gradient.colors
			for j in _inventory:
				if j is not Alloy: continue
				if j.lvl == item.lvl:
					var j_cols := j.shader_gradient.gradient.colors
					var cols_exacts := true
					for k in item_cols.size():
						if item_cols[k] != j_cols[k]:
							cols_exacts = false
							break
					if cols_exacts:
						add_item(j, count)
						return
		_inventory[item] = count
	inventory_changed.emit(_inventory)


func remove_item(item: Item, count := 1) -> bool:
	if _inventory.has(item):
		if _inventory[item] < count:
			push_error("Can't remove %s items " % str(count), item, " from inventory ", get_inventory())
			return false
		_inventory[item] -= count
		if _inventory[item] == 0:
			_inventory.erase(item)
	else:
		for j in _inventory:
			if item.color == j.color:
				return remove_item(j, count)
		push_error("Can't remove item ", item, " from inventory ", get_inventory())
		return false
	inventory_changed.emit(_inventory)
	return true

#endregion

#region Private funcs

#endregion

#region Godot funcs

func _ready() -> void:
	i = self

#endregion

#region Signal funcs

#endregion
