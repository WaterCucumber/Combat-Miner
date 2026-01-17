extends Node
class_name AlloyCreator

# Signals
# Enums
# Consts
# Static vars
static var i : AlloyCreator
# Public vars
var can_add_item := true
# Export vars
# Onready vars
@onready var result: ItemInput = %Result
@onready var in_1: ItemInput = %In1
@onready var in_2: ItemInput = %In2
@onready var in_3: ItemInput = %In3
@onready var inputs : Array[ItemInput] = [in_1, in_2, in_3]
# Private vars

# Funcs
#region Public funcs

func add_to_input(item: Item):
	if not can_add_item: return
	_input_added(item)

#endregion

#region Private funcs

func _input_added(added_item: Item):
	# Inputs Full
	var items : Array[Item]
	for inp in inputs:
		var item: Item = inp.get_item()
		if not item: 
			if not added_item:
				return
			inp.add_item(added_item)
			item = added_item
			added_item = null
		items.append(item)
	can_add_item = false
	result.add_item(Alloy.new(items))

#endregion

#region Godot funcs

func _init() -> void:
	i = self


func _ready() -> void: 
	for inp in inputs:
		inp.item_removed.connect(_on_input_item_removed)

#endregion

#region Signal funcs

func _on_input_item_removed(item: Item) -> void:
	result.remove_item()
	can_add_item = true
	PlayerInventory.i.add_item(item)


func _on_result_item_removed(item: Item) -> void:
	for inp in inputs:
		inp.remove_item()
	can_add_item = true
	PlayerInventory.i.add_item(item)

#endregion
