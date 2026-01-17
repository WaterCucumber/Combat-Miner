extends HFlowContainer

const ITEM_UI = preload("uid://im5co7o3hpvx")

@export var for_ores := true
var items_ui : Dictionary[ItemUI, Item]

func _ready() -> void:
	PlayerInventory.i.inventory_changed.connect(_on_inventory_changed)
	_create_items()


func _create_items():
	var inv = PlayerInventory.i.get_inventory()
	for i in inv:
		if i is Ore == for_ores:
			var quantity : int = inv[i]
			_initialize_item(i, quantity)


func _initialize_item(item_res: Item, quantity: int):
	var item : ItemUI = ITEM_UI.instantiate()
	add_child(item)
	item.initialize(item_res, quantity)
	items_ui[item] = item_res
	item.tree_exited.connect(func(): items_ui.erase(item))


func _on_inventory_changed(inventory: Dictionary[Item, int]):
	var vs = items_ui.values()
	for i in inventory:
		if i is Ore == for_ores:
			if vs.has(i):
				continue
			_initialize_item(i, inventory[i])
