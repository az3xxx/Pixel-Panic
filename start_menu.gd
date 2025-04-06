extends Node2D

@onready var intro_music = $intro_music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if intro_music.playing == false:
		intro_music.play()


func _on_start_pressed() -> void:
	read_file()
	get_tree().change_scene_to_file("res://node_2d.tscn")
	#get_tree().change_scene_to_file("res://cave.tscn")
	
func _on_new_game_pressed() -> void:
	# trebuie sa resetam fisierul
	print("new game pressed")

func _on_quit_pressed() -> void:
	write_file()
	get_tree().quit()

func read_file():
	if FileAccess.file_exists("progress.txt"):
		var file = FileAccess.open("progress.txt", FileAccess.READ)
		
		print(file.get_var())
		print(file.get_var())
		print(file.get_var())
		
func write_file():
	var file = FileAccess.open("progress.txt", FileAccess.WRITE);
	
	file.store_var(1);
	file.store_var("lup");
	file.store_var("animal");
	
	
	
	
	
