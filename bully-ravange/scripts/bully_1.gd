extends CharacterBody2D

func _ready() -> void:
	if not NPCs.npcs.has("res://scenes/bully1.tscn"):
		NPCs.npcs["res://scenes/bully1.tscn"]=get_parent().name
