extends PanelContainer

signal item_hovered(item_name: String)

var current_item_name: String = ""

@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var amount_label: Label = $HBoxContainer/AmountLabel
@onready var icon: TextureRect = $HBoxContainer/TextureRect


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)


func setup(item_name: String, amount: int) -> void:
	current_item_name = item_name

	var item_data: Dictionary = ItemDatabase.get_item(item_name)

	name_label.text = item_name
	amount_label.text = "x" + str(amount)

	if item_data.is_empty():
		icon.texture = null
		return

	name_label.text = item_data["name"]
	icon.texture = item_data["icon"]


func _on_mouse_entered() -> void:
	if current_item_name != "":
		item_hovered.emit(current_item_name)
