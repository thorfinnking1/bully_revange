extends Area2D

@export_file("*.tscn") var pathtooroom:String
@onready var marker: Marker2D = $Marker2D

@export var plr:CharacterBody2D

var check = false

func _ready() -> void:
	if Al.roomcamefrom == name:
		plr.global_position = marker.global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		call_deferred("change_scene",pathtooroom)

func change_scene(path:String):
	Al.roomcamefrom=get_parent().name
	get_tree().change_scene_to_file(path)
