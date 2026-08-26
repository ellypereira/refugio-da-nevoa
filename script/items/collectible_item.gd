extends Area2D

@export_category("Item")
@export var item_name: String = "Luz da Névoa"
@export var amount: int = 1


func interact() -> void:
	InventoryManager.add_item(item_name, amount)

	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	if dialogue_ui:
		var lines: Array[String] = [
			"Você encontrou: " + item_name + "!"
		]

		dialogue_ui.start_dialogue(lines)

	queue_free()
