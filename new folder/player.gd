extends CharacterBody2D

const SPEED = 55.0
const JUMP_VELOCITY = -120.0
const GRAVITY = 400.0  # reasonable platformer gravity
const MAX_LEFT = -320
const MAX_RIGHT = 764
const MAX_BOTTOM = 128
const MAX_TOP = -110

const difference = 320 - 32
const difference2 = 128 + 32

@onready var camera = $Camera2D
@onready var character = $"."
@onready var body = $body

var bottom_limit
var up_limit
var left_limit
var right_limit

var z = 0.0  # Variabila pentru offset-ul pe axa Y

func _physics_process(delta: float) -> void:
	#if (velocity.x > 1 || velocity.x < -1):
		#body.animation = "run2"
	#else:
		#body.animation = "idle2"
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		#body.animation = "jump2"
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("left", "right")
	
	move_and_slide()
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _ready() -> void:
	camera.enabled = true
	camera.offset = Vector2(-60, z)  # Setează offset-ul pe axa Y
	bottom_limit = 160
	up_limit = -32
	left_limit = -350
	right_limit = -100
	camera.set_limit(SIDE_BOTTOM, bottom_limit)
	camera.set_limit(SIDE_TOP, up_limit)
	camera.set_limit(SIDE_LEFT, left_limit)
	camera.set_limit(SIDE_RIGHT, right_limit)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	
func _process(delta: float) -> void:
	# Actualizăm limitele pentru X (dreapta și stânga)
	if character.position.x - right_limit < 500 and right_limit < MAX_RIGHT:
		right_limit += difference
	if character.position.x - left_limit < 500 and left_limit > MAX_LEFT:
		left_limit -= difference
	
	# Actualizăm limitele pentru Y (sus și jos)
	if character.position.y - bottom_limit < 50 and bottom_limit < MAX_BOTTOM:
		bottom_limit += difference2
	if character.position.y - up_limit < 1000 and up_limit < MAX_TOP:
		up_limit -= difference2
	
	# Actualizarea offset-ului pentru camera pe axa Y (modificăm z)
	z = character.position.y * 0.4  # Crește acest factor pentru a accelera mișcarea camerei pe axa Y
	camera.offset = Vector2(-60, z)  # Setăm offset-ul pe axa Y

	# Previne trecerea camerei dincolo de MAX_BOTTOM pe axa Y
	if camera.offset.y > MAX_BOTTOM:
		camera.offset.y = MAX_BOTTOM  # Limitează camera la valoarea maximă pe axa Y

	# Setează limitele camerei
	camera.set_limit(SIDE_BOTTOM, bottom_limit)
	camera.set_limit(SIDE_TOP, up_limit)
	camera.set_limit(SIDE_LEFT, left_limit)
	camera.set_limit(SIDE_RIGHT, right_limit)
