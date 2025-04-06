extends CharacterBody2D

const SPEED = 200.0

@export var point_on_line := Vector2(0, 648)       # A point on the line
@export var line_direction := Vector2(-1, 0)     # The direction of the line (normalized)
@export var min_scale := 0.6
@export var max_scale := 1
@export var max_distance := 1500.0

func _process(delta):
	var to_player = position - point_on_line

	# Project vector onto the direction perpendicular to the line
	var line_normal = Vector2(-line_direction.y, line_direction.x)  # Rotate 90°
	var distance = abs(to_player.dot(line_normal.normalized()))

	# Convert distance into scale
	var scale_factor = clamp(1.0 - (distance / max_distance), min_scale, max_scale)
	scale = Vector2(scale_factor, scale_factor)


func _physics_process(delta: float) -> void:

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var up_down = Input.get_axis("ui_up", "ui_down")
	if up_down:
		velocity.y = up_down * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
