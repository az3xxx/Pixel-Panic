extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

const NORMAL_ATTACK = 12

@onready var body = $body
@onready var right_collision = $collision
@onready var left_collision = $collision2

@onready var leave_button = $"../leave"

@onready var mushroom = $"../mushroom"
@onready var mushroom_body = $"../mushroom/body"
@onready var player = $"."


var position_player
var contor
var contor_jump
var contor_timer
var contor_timer_jump


# ia cu position

var first

var one_jump

var initial_mushroom_pos
var target_mushroom_pos
var minus

func _ready() -> void:
	first = false
	
	contor = false
	
	contor_timer = 0
	contor_timer_jump = 0
	
	# nu sterge iti trebuie!!!
	left_collision.set_disabled(true)
	
	one_jump = true
	
	initial_mushroom_pos = mushroom.position
	target_mushroom_pos = Vector2(initial_mushroom_pos.x + 10, initial_mushroom_pos.y - 50)
	
	minus = false

func _physics_process(delta: float) -> void:
	if (contor == false):
		if (velocity.x > 1 || velocity.x < -1):
			body.animation = "run2"
		else:
			body.animation = "idle2"
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if (contor == false):
			body.animation = "jump2"
		else:
			if (contor_jump == false):
				body.animation = "jump_attack_2"
				contor_jump = true
				contor_timer_jump = 1
				
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("left", "right")

	if Input.is_action_just_pressed('left'):
		body.flip_h = true
		
	if Input.is_action_just_pressed('right'):
		body.flip_h = false
	
	if Input.is_action_just_pressed('attack'):
		body.animation = "2_attack_2"
		contor = true
		contor_timer = 1
		mushroom.health = mushroom.health - NORMAL_ATTACK
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	mushroom_jump(delta)


func mushroom_jump(delta):
	if (mushroom.position != target_mushroom_pos):
		mushroom.position = mushroom.position.move_toward(target_mushroom_pos, delta * SPEED)
		mushroom_body.animation = "jump"
	else:
		if (minus):
			target_mushroom_pos = Vector2(mushroom.position.x + 10, mushroom.position.y - 50)
			minus = false
		else:
			target_mushroom_pos = Vector2(mushroom.position.x + 10, mushroom.position.y + 50)
			minus = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (contor == true):
		contor_timer = contor_timer + 1
	else:
		contor_timer = contor_timer - 1
		
	if (contor_timer > 100):
		contor = false
	
	if (contor_jump == true):
		contor_timer_jump = contor_timer_jump + 1
	else:
		contor_timer_jump = contor_timer_jump - 1
		
	if (contor_timer_jump > 100):
		contor_jump = false
	
func _on_cave_body_entered(body: Node2D) -> void:
	if (first == false):
		first = true
	else:
		leave_button.visible = true

func _on_cave_body_exited(body: Node2D) -> void:
	leave_button.visible = false

func _on_void_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://start_menu.tscn")
