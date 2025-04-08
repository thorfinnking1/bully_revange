extends Area2D

@export_file("*.tscn") var pathtooroom:String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		get_tree().change_scene_to_file(pathtooroom)
