extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var body = $body
@onready var mushroom = $"."

var health = 120

var minus

var body_inside

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	
	#var new_pos = Vector2(mushroom.position.x + 10, mushroom.position.y - 10)
	#mushroom.position = mushroom.position.move_toward(new_pos, delta * SPEED)
	#body.animation = "jump"
	
	
	#if (mushroom.position == new_pos):
		#body.animation = "idle"
	pass

func _ready() -> void:
	body.flip_h = true
	body_inside = false

func jump_back(delta: float, final_pos) -> void:
	#var new_pos = Vector2(mushroom.position.x + 10, mushroom.position.y - 100)
	
	mushroom.position = mushroom.position.move_toward(final_pos, delta * SPEED)
	body.animation = "jump"
	
	if (mushroom.position == final_pos):
		body.animation = "idle"
	
	#new_pos = Vector2(mushroom.position.x + 10, mushroom.position.y + 20)
	#mushroom.position = mushroom.position.move_toward(new_pos, delta * SPEED)
	

#func _on_area_2d_body_entered(body) -> void:
	#if (body.name == "player"):
		#print("entered")
		#body_inside = true
#
#func _on_area_2d_body_exited(body: Node2D) -> void:
	#if (body.name == "player"):
		#print("entered")
		#body_inside = false
