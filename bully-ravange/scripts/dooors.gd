extends Area2D

@export var door :Area2D
@onready var marker: Marker2D = $Marker2D

@export var camera:Camera2D
@export var cameraout:Camera2D

@export var plr:CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		cameraout.enabled=false
		camera.enabled = true
		body.global_position = door.marker.global_position
