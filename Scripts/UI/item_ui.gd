extends PanelContainer
class_name ItemUI

# Signals
signal added(item: Item)
# Enums
# Consts
# Static vars
# Public vars
# Export vars
@export var _item: Item
# Onready vars
@onready var animated_item_texture = %AnimatedItemTexture
@onready var animated_tex: AnimatedItemTexture = animated_item_texture.animated_tex
@onready var quantity_label: Label = %QuantityLabel
@onready var add_button: Button = %AddButton
# Private vars

# Funcs
#region Public funcs

func initialize(item: Item, quantity : int):
	_item = item
	add_button.disabled = _item is Alloy and _item.lvl == Alloy.Level.THIRD
	animated_tex.play_item_anim(item)
	_update_quantity_text(quantity)

#endregion

#region Private funcs

func _update_quantity_text(quantity: int):
	quantity_label.text = "x" + str(quantity)

#endregion

#region Godot funcs

func _ready() -> void:
	PlayerInventory.i.inventory_changed.connect(_on_inventory_changed)

#endregion

#region Signal funcs

func _on_inventory_changed(inventory: Dictionary[Item, int]):
	if not inventory.has(_item):
		queue_free()
		return

	if _item is Alloy and _item.lvl == Alloy.Level.THIRD:
		add_button.disabled = true
	else:
		add_button.disabled = not AlloyCreator.i.can_add_item

	var quantity = inventory[_item]
	_update_quantity_text(quantity)


func _on_add_button_pressed() -> void:
	added.emit(_item)
	AlloyCreator.i.add_to_input(_item)
	PlayerInventory.i.remove_item(_item)

#endregion
