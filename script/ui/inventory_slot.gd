extends PanelContainer

@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var amount_label: Label = $HBoxContainer/AmountLabel
@onready var icon: TextureRect = $HBoxContainer/TextureRect


func setup(item_name: String, amount: int) -> void:
	name_label.text = item_name
	amount_label.text = "x" + str(amount)

	match item_name:
		"Luz da Névoa":
			icon.texture = preload("res://assets/sprites/items/icons/luz_da_nevoa.png")
		_:
			icon.texture = null
