extends Control

var acumulatTime=0.0

@onready var label: Label = $Label
@onready var stuff: Label = $Label2

var mins=0
var hours=8

var clas = "a"

const SPEED=30.0

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
				hours=1
	
	label.text = "%s:%s" % [str(hours).pad_zeros(2),str(mins).pad_zeros(2)]
	
	if hours <= 10 and mins==50:
		stuff.text = "Class " + clas
	elif hours>=11 and mins>=10:
		stuff.text = "Class " + clas
	elif hours==1 and mins>=10:
		stuff.text = "Class " + clas
	else:
		stuff.text= "break"
