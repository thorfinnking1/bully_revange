extends CharacterBody2D

@export var points:Node2D

var targetpos
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	choosepoint(points)

func _physics_process(_delta: float) -> void:
	if nav.is_navigation_finished():
		choosepoint(points)
	var nextp=nav.get_next_path_position()
	velocity=(nextp-global_position).normalized()*200
	move_and_slide()

func choosepoint(poins):
	var n = randi_range(0,poins.get_child_count()-1)
	targetpos=poins.get_child(n).global_position
	nav.target_position=targetpos
