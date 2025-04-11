extends CharacterBody2D

@onready var  d  = $d
@onready var c = $c
@onready var b = $b
@onready var s = $s
@onready var ani = $AnimationPlayer
@onready var skel = $Skeleton2D
@onready var timer : Timer = $Timer

@onready var limbs = [$d/blood,$c/Polygon2D8,$c/Polygon2D4,$c/Polygon2D9,$c/Polygon2D10,$c/Polygon2D11,$c/Polygon2D12,$b/Polygon2D7,$s/Polygon2D7]
var state = "normal"

# In your player or main node script:
var idle = false
var waiting = false
var playing_idle_variation = false
const SPEED =  200.0
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dani"):
		d.visible= true
		c.visible= false
		b.visible= false
		s.visible= false
	if Input.is_action_just_pressed("cristi"):
		d.visible= false
		c.visible= true
		b.visible= false
		s.visible= false
	if Input.is_action_just_pressed("bea"):
		d.visible= false
		c.visible= false
		b.visible= true
		s.visible= false
	if Input.is_action_just_pressed("mina"):
		d.visible= false
		c.visible= false
		b.visible= false
		s.visible= true
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
	if direction == 1:
		if not playing_idle_variation:
			ani.play("walking")
		d.scale.x = 1
		c.scale.x = 1.145
		b.scale.x = 1
		s.scale.x = 1
		skel.scale.x = 1
		idle = false
	elif direction == -1:
		if not playing_idle_variation:
			ani.play("walking")
		d.scale.x = -1
		c.scale.x = -1.145
		b.scale.x = -1
		s.scale.x = -1
		skel.scale.x = -1
		idle = false
	elif up_down == 1 or up_down == -1:
		idle = false
		if not playing_idle_variation:
			ani.play("walking")  # te miști în sus sau jos, nu flipăm
	else:
		if not playing_idle_variation:
			ani.play("idle")
		idle = true
	if playing_idle_variation and (direction or up_down):
		ani.stop()
		playing_idle_variation = false
		waiting = false
		

func _process(_delta):
	if state=="killer":
		for i in limbs:
			i.visible = true
	else:
		for i in limbs:
			i.visible = false
	# dacă e idle și nu așteptăm deja, pornește procesul de random
	if idle and not waiting:
		waiting = true
		start_random_action()

func start_random_action() -> void:
	var time = randi_range(60,120)
	timer.start(time)
	await timer.timeout
	if idle:
		randomize()
		var n = randi_range(1, 1)
		match n:
			1:
				playing_idle_variation =true
				print("1")
				if d.visible== true:
					ani.play("idle_ani_1")
				elif c.visible== true:
					ani.play("idle_ani_1")
				elif b.visible== true:
					ani.play("bea_ani_1")
				elif s.visible== true:
					ani.play("idle_ani_1")
				await ani.animation_finished
				playing_idle_variation = false
				ani.play("idle")
			2:
				print(100)
			3:
				print(200)
	waiting = false


func _ready():
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("j"):
		state="normal"
	elif Input.is_action_just_pressed("k"):
		state="killer"
