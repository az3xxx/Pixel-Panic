extends CharacterBody2D

const speed = 100

@onready var body = $"./body"

var contor
var contor_timer

var first_time = 4

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if (contor == false):
		if input_direction:
			body.animation = "run2"
		else:
			body.animation = "idle2"
	
	if Input.is_action_just_pressed('left'):
		body.flip_h = true
		
	if Input.is_action_just_pressed('right'):
		body.flip_h = false
	
	if Input.is_action_just_pressed('attack'):
		body.animation = "2_attack_2"
		contor = true
		contor_timer = 1
	
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (contor == true):
		contor_timer = contor_timer + 1
	else:
		contor_timer = contor_timer - 1
		
	if (contor_timer > 100):
		contor = false

func _ready() -> void:
	contor = false
	
	contor_timer = 0

func _on_casa_1_body_entered(body: Node2D) -> void:
	if (first_time == 0):
		get_tree().change_scene_to_file("res://casa1.tscn")
	else:
		first_time = first_time - 1

func _on_casa_2_body_entered(body: Node2D) -> void:
	if (first_time == 0):
		get_tree().change_scene_to_file("res://casa2.tscn")
	else:
		first_time = first_time - 1

func _on_casa_3_body_entered(body: Node2D) -> void:
	if (first_time == 0):
		get_tree().change_scene_to_file("res://casa3.tscn")
	else:
		first_time = first_time - 1

func _on_casa_4_body_entered(body: Node2D) -> void:
	if (first_time == 0):
		get_tree().change_scene_to_file("res://casa4.tscn")
	else:
		first_time = first_time - 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://cave.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cave.tscn")
