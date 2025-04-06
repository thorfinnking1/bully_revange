extends CharacterBody2D

@export var base_speed := 200.0  # Max speed when right on the line
@export var point_on_line := Vector2(0, 648)
@export var line_direction := Vector2(-1, 0)
@export var max_distance := 1250.0  # At this distance, speed might be negative

@export var min_scale := 0.3
@export var max_scale := 1.0

func _process(delta):
	var to_player = position - point_on_line
	var line_normal = Vector2(-line_direction.y, line_direction.x)
	var distance = abs(to_player.dot(line_normal.normalized()))

	# Visual size based on distance from the line
	var scale_factor = clamp(1.0 - (distance / max_distance), min_scale, max_scale)
	scale = Vector2(scale_factor, scale_factor)

func _physics_process(delta):
	var to_player = position - point_on_line
	var line_normal = Vector2(-line_direction.y, line_direction.x)
	var distance = abs(to_player.dot(line_normal.normalized()))

	# Movement speed modifier based on distance from line
	var speed_factor = 1.0 - (distance / max_distance)
	
	# Optionally clamp to allow some limits, or allow negative for reverse
	speed_factor = clamp(speed_factor, -1.0, 1.0)  # You can remove this if you want crazy speeds
	
	var actual_speed = base_speed * speed_factor

	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	velocity = input_direction * actual_speed
	move_and_slide()
