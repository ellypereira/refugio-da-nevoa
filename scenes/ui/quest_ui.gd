extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var quest_name_label: Label = $Panel/QuestNameLabel
@onready var objective_label: Label = $Panel/ObjectiveLabel
@onready var status_label: Label = $Panel/StatusLabel


func _ready() -> void:
	panel.hide()


func _process(_delta: float) -> void:
	var quest_state := QuestManager.get_quest_state("erva_para_lumi")

	if quest_state == "active":
		update_quest()
		panel.show()
	else:
		panel.hide()


func update_quest() -> void:
	var ervas: int = InventoryManager.items.get("Erva Serena", 0)

	quest_name_label.text = "Ervas para Lumi"
	objective_label.text = "Erva Serena: " + str(ervas) + " / 2"

	if ervas >= 2:
		status_label.text = "Volte para Lumi"
	else:
		status_label.text = "Missão em andamento"
