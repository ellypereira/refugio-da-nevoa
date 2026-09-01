
extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var items_container: VBoxContainer = $Panel/ItemsContainer

var inventory_slot_scene = preload("res://scenes/ui/inventory_slot.tscn")


var is_open: bool = false


func _ready() -> void:
	panel.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		toggle_inventory()
		get_viewport().set_input_as_handled()


func toggle_inventory() -> void:
	is_open = not is_open

	if is_open:
		update_inventory()
		panel.show()
	else:
		panel.hide()


func update_inventory() -> void:
	for child in items_container.get_children():
		child.queue_free()

	# Inventário vazio.
	if InventoryManager.items.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Inventário vazio."
		items_container.add_child(empty_label)
		return

	# Cria um InventorySlot para cada item.
	for item_name in InventoryManager.items:
		var amount: int = InventoryManager.items[item_name]

		var slot = inventory_slot_scene.instantiate()

		items_container.add_child(slot)

		slot.setup(item_name, amount)
