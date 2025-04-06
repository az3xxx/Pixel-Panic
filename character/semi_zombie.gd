extends CharacterBody2D
#
const SPEED = 15.0
#const JUMP_VELOCITY = -250.0
#
@onready var body = $body 
@onready var character = $"."

var target_pos

var up
var down

var attack_timer 
var active_attack

var area_entered

@onready var player = %player2

#
#@onready var leave_button = $"../leave"
#
#var first
#
#func _ready() -> void:
	#first = false
#
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#
	#var direction := Input.get_axis("left", "right")
	#
	#move_and_slide()
#
	#if Input.is_action_just_pressed('left'):
		#body.flip_h = true
#
	#if Input.is_action_just_pressed('right'):
		#body.flip_h = false
		#
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
#
#func _on_cave_body_entered(body: Node2D) -> void:
	#if (first == false):
		#first = true
	#else:
		#leave_button.visible = true
#
#func _on_cave_body_exited(body: Node2D) -> void:
	#leave_button.visible = false
#
#
#func _on_void_body_entered(body: Node2D) -> void:
	#get_tree().change_scene_to_file("res://start_menu.tscn")
	
func _ready() -> void:
	body.animation = "default"
	
	up = character.position
	down = Vector2(character.position.x, character.position.y + 100)
	
	target_pos = down
	
	attack_timer = 0
	active_attack = false
	
	area_entered = false

func _physics_process(delta: float) -> void:
	if (character.position == target_pos):
		if (target_pos == up):
			target_pos = down
		else:
			target_pos = up
		
	character.position = character.position.move_toward(target_pos, delta * SPEED)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player.contor == true and area_entered == true):
			queue_free()
	
	if (active_attack == true):
		attack_timer = attack_timer + 1
	
	if (attack_timer == 300 and area_entered == true):
		get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_area_2d_body_entered(body) -> void:
	if (body.name == "player2"):
		if (active_attack == false):
			attack_timer = 0
			active_attack = true
			
			area_entered = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "player2"):
		area_entered = false
		active_attack = false
		
