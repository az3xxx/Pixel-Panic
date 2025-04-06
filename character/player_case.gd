extends CharacterBody2D

const speed = 135

@onready var body = $"./body"

#@onready var panel = $"../Panel"
#@onready var text = $"../Panel/Label"

var contor
var contor_timer

var first_time = 4

var timer
var got_item

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
	
	#panel.visible = false
	#text.visible = false
	
	timer = 0
	got_item = false
	#
	#if (got_item == true):
		#timer = timer + 1
	#
	#if (timer > 20):
		#panel.visibility = false


#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if (got_item == false):
		#panel.visible = true
		#text.visible = true
		#got_item = true

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
