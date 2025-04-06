extends Area2D

@onready var leave_button = $leave


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	leave_button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_leave_pressed() -> void:
	get_tree().change_scene_to_file("res://map.tscn")
