extends Area2D


func interact() -> void:
	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	if dialogue_ui:
		var lines: Array[String] = [
			"A névoa parece mais densa adiante...",
			"Alguns viajantes dizem ouvir sinos vindos da floresta.",
			"Talvez seja melhor seguir pela trilha."
		]

		dialogue_ui.start_dialogue(lines)
