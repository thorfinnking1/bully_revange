extends Control

var acumulatTime=0.0

@onready var label: Label = $Label

var mins=0
var hours=8

const SPEED=120.0

func _process(delta: float) -> void:
	acumulatTime += delta*SPEED
	
	if acumulatTime>=60:
		mins+=1
		acumulatTime-=60
		if mins>=60:
			mins=0
			hours+=1
			if hours == 2:
				get_tree().change_scene_to_file("res://scenes/room_1.tscn")
			elif hours>=13:
				hours=0
	
	label.text = "%s:%s" % [str(hours).pad_zeros(2),str(mins).pad_zeros(2)]
