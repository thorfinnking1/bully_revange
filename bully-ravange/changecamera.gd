extends Area2D

@export var camera:Camera2D
@export var cameraout:Camera2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		cameraout.enabled=false
		camera.enabled = true
