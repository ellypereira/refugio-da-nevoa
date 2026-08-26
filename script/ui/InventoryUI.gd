
extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var items_container: VBoxContainer = $Panel/ItemsContainer

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

	if InventoryManager.items.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Inventário vazio."
		items_container.add_child(empty_label)
		return

	for item_name in InventoryManager.items:
		var amount: int = InventoryManager.items[item_name]

		var item_label := Label.new()
		item_label.text = item_name + "   x" + str(amount)

		items_container.add_child(item_label)
