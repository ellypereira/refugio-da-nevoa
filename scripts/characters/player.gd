extends CharacterBody2D

# ============================================================
# REFÚGIO DA NÉVOA
# Player Controller
# ============================================================

@export_category("Movimento")
@export var move_speed: float = 120.0

var move_direction: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	move_direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	velocity = move_direction * move_speed
	move_and_slide()
	
	if move_direction != Vector2.ZERO:
		print("PLAYER", global_position, "VELOCITY: ", velocity)
