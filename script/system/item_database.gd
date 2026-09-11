extends Node

const ITEMS := {
	"Luz da Névoa": {
		"name": "Luz da Névoa",
		"description": "Uma pequena chama de energia encontrada entre a névoa.",
		"type": "material",
		"icon": preload("res://assets/sprites/items/icons/luz_da_nevoa.png")
	},

	"Erva Serena": {
		"name": "Erva Serena",
		"description": "Uma erva delicada que cresce em lugares tranquilos.",
		"type": "plant",
		"icon": preload("res://assets/sprites/items/icons/erva_serena.png")
	}
}


func get_item(item_name: String) -> Dictionary:
	if ITEMS.has(item_name):
		return ITEMS[item_name]

	return {}
