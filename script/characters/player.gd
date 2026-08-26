extends CharacterBody2D

@export var speed: float = 120.0

@onready var interaction_area: Area2D = $InteractionArea


func _physics_process(_delta: float) -> void:
	
	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")
	var InventoryUI = get_tree().get_first_node_in_group("InventoryUI")
	# Enquanto houver diálogo, o personagem fica parado.
	if dialogue_ui and dialogue_ui.is_open:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if InventoryUI and InventoryUI.is_open:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact"):
		return

	var dialogue_ui = get_tree().get_first_node_in_group("dialogue_ui")

	# Enquanto um diálogo estiver aberto,
	# a DialogueUI cuida do E.
	if dialogue_ui and dialogue_ui.is_open:
		return

	var areas := interaction_area.get_overlapping_areas()

	if areas.is_empty():
		return

	var target: Area2D = areas[0]

	# Caso 1: o próprio Area2D é interagível.
	# Exemplo: TestSign.
	if target.has_method("interact"):
		target.interact()
		get_viewport().set_input_as_handled()
		return

	# Caso 2: o Area2D pertence a um objeto interagível.
	# Exemplo: Lumi -> InteractionArea.
	var parent := target.get_parent()

	if parent and parent.has_method("interact"):
		parent.interact()
		get_viewport().set_input_as_handled()
