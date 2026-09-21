extends CharacterBody2D

# ============================================================
# REFÚGIO DA NÉVOA
# NPC Base
# ============================================================

@export_category("Identidade")
@export var npc_name: String = "Habitante"

@export_category("Primeira conversa")
@export var dialogue_lines: Array[String] = [
	"Olá..."
]

@export_category("Conversas seguintes")
@export var repeat_dialogue_lines: Array[String] = [
	"Olá novamente."
]

# Guarda se o jogador já conversou com este NPC.
var has_talked: bool = false


func interact() -> void:
	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	if dialogue_ui == null:
		return

	var quest_state := QuestManager.get_quest_state("erva_para_lumi")


	if quest_state == "not_started":
		var lines: Array[String] = [
		"Oi... você poderia me ajudar?",
		"Algumas Ervas Serena crescem por esta clareira.",
        "Traga 2 delas para mim."
	]

		dialogue_ui.dialogue_closed.connect(
		func():
			QuestManager.start_quest("erva_para_lumi")
	, CONNECT_ONE_SHOT)
		
		dialogue_ui.start_dialogue(lines, npc_name)
	return


	if quest_state == "active":
		var ervas: int = InventoryManager.items.get("Erva Serena", 0)

		if ervas >= 2:
			InventoryManager.remove_item("Erva Serena", 2)
			# Recompensa da missão
			InventoryManager.add_item("Luz da Névoa", 1)
			
			QuestManager.complete_quest("erva_para_lumi")

			var lines: Array[String] = [
				"Você encontrou as Ervas Serena!",
				"Obrigada... elas serão muito úteis.",
				"Pegue isto em troca.",
				"Esta Luz da Névoa talvez consiga guiá-lo por lugares onde a névoa é mais densa."
			]

			dialogue_ui.start_dialogue(lines, npc_name)

		else:
			var lines: Array[String] = [
				"Ainda precisamos de 2 Ervas Serena.",
				"Você encontrou " + str(ervas) + " até agora."
			]

			dialogue_ui.start_dialogue(lines, npc_name)

		return


	if quest_state == "completed":
		var lines: Array[String] = [
			"Obrigada novamente pelas Ervas Serena.",
			"A clareira parece um pouco mais tranquila agora."
		]

		dialogue_ui.start_dialogue(lines, npc_name)
