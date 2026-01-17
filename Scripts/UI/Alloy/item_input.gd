extends TextureRect
class_name ItemInput

# Signals
signal item_removed(item: Item)
# Onready vars
@onready var _animated_item_texture: PanelContainer = $AnimatedItemTexture
@onready var _anim: AnimatedItemTexture = _animated_item_texture.animated_tex
@onready var _remove_button: Button = $RemoveButton
# Private vars
var _item : Item

# Funcs
#region Public funcs

func add_item(item: Item):
	_item = item
	_item_added()


func get_item() -> Item:
	return _item


func remove_item():
	_item_removed()

#endregion

#region Private funcs

func _item_removed():
	_animated_item_texture.hide()
	_remove_button.disabled = true
	_item = null


func _item_added():
	_anim.play_item_anim(_item)
	_animated_item_texture.show()
	_remove_button.disabled = false

#endregion

#region Godot funcs

#endregion

#region Signal funcs

func _on_remove_button_pressed() -> void:
	item_removed.emit(_item)
	_item_removed()

#endregion
