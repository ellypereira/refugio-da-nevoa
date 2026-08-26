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
		push_warning("DialogueUI não encontrada.")
		return

	# Primeira conversa
	if not has_talked:
		dialogue_ui.start_dialogue(dialogue_lines, npc_name)
		has_talked = true

	# Conversas seguintes
	else:
		dialogue_ui.start_dialogue(repeat_dialogue_lines, npc_name)
