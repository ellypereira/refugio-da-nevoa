extends Node

# Guarda os itens que o jogador possui.
var items: Dictionary = {}


func add_item(item_name: String, amount: int = 1) -> void:
	if items.has(item_name):
		items[item_name] += amount
	else:
		items[item_name] = amount

	print("=== INVENTÁRIO ===")
	print(items)


func has_item(item_name: String, amount: int = 1) -> bool:
	return items.get(item_name, 0) >= amount


func get_item_amount(item_name: String) -> int:
	return items.get(item_name, 0)
