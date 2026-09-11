extends Node

var quests: Dictionary = {
	"erva_para_lumi": {
		"name": "Ervas para Lumi",
		"description": "Encontre 2 Ervas Serena para Lumi.",
		"required_item": "Erva Serena",
		"required_amount": 2,
		"state": "not_started"
	}
}


func start_quest(quest_id: String) -> void:
	if not quests.has(quest_id):
		return

	if quests[quest_id]["state"] == "not_started":
		quests[quest_id]["state"] = "active"
		print("Missão iniciada: ", quests[quest_id]["name"])


func get_quest_state(quest_id: String) -> String:
	if not quests.has(quest_id):
		return "not_found"

	return quests[quest_id]["state"]


func complete_quest(quest_id: String) -> void:
	if not quests.has(quest_id):
		return

	quests[quest_id]["state"] = "completed"
	print("Missão concluída: ", quests[quest_id]["name"])
