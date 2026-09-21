extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/Label
@onready var continue_label: Label = $Panel/ContinueLabel
@onready var name_label: Label = $Panel/NameLabel
signal dialogue_closed

# Falas do diálogo atual
var dialogue_lines: Array[String] = []
var current_line: int = 0

# Estado do diálogo
var is_open: bool = false
var is_typing: bool = false

# Velocidade da digitação
@export var typing_speed: float = 0.035


func _ready() -> void:
	panel.hide()
	continue_label.hide()
	name_label.hide()


func _process(_delta: float) -> void:
	if not is_open:
		return

	if not is_typing:
		var alpha := 0.5 + sin(Time.get_ticks_msec() * 0.005) * 0.5
		continue_label.modulate.a = alpha


func _unhandled_input(event: InputEvent) -> void:
	if not is_open:
		return

	if event.is_action_pressed("interact"):
		if is_typing:
			finish_typing()
		else:
			next_line()

		get_viewport().set_input_as_handled()


func start_dialogue(lines: Array[String], speaker_name: String = "") -> void:
	if lines.is_empty():
		return

	if is_open:
		return

	dialogue_lines = lines
	current_line = 0
	is_open = true

	# Nome de quem está falando
	if speaker_name.is_empty():
		name_label.hide()
	else:
		name_label.text = speaker_name
		name_label.show()

	panel.show()
	show_current_line()


func show_current_line() -> void:
	var text := dialogue_lines[current_line]

	label.text = text
	label.visible_characters = 0

	is_typing = true
	continue_label.hide()

	type_text(text)


func type_text(text: String) -> void:
	for i in range(text.length()):
		if not is_typing:
			return

		label.visible_characters = i + 1
		await get_tree().create_timer(typing_speed).timeout

	if is_typing:
		is_typing = false
		continue_label.show()
		continue_label.modulate.a = 1.0


func finish_typing() -> void:
	is_typing = false
	label.visible_characters = -1

	continue_label.show()
	continue_label.modulate.a = 1.0


func next_line() -> void:
	current_line += 1

	if current_line >= dialogue_lines.size():
		close_dialogue()
		return

	show_current_line()


func close_dialogue() -> void:
	panel.hide()

	dialogue_lines.clear()
	current_line = 0

	is_open = false
	is_typing = false

	label.visible_characters = -1

	continue_label.hide()
	name_label.hide()
	continue_label.modulate.a = 1.0
	
	dialogue_closed.emit()
