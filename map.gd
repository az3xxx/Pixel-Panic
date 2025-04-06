extends CanvasLayer

@onready var music1 = $music_1
@onready var music2 = $music_2

@onready var current_music;

@onready var text_array = [$ColorRect/letter_text, $ColorRect/axe_text, $ColorRect/seed_text, $ColorRect/journal_text,
$ColorRect/fire_crackers_text, $ColorRect/torch_text, $ColorRect/weapon_text, $ColorRect/ritual_text]
@onready var button_array = [$ColorRect/letter, $ColorRect/axe, $ColorRect/seed, $ColorRect/journal, $ColorRect/fire_crackers,
$ColorRect/torch, $ColorRect/weapon, $ColorRect/ritual]
@onready var background = $ColorRect
@onready var text_panel = $Panel
@onready var item_text = $Panel/Label
enum button_type_enum {LETTER, AXE, SEED, JOURNAL, FIRE_CRACKERS, TORTH, WEAPON, RITUAL, NONE}
var button_type

var journal_message = "A fairy well maintained journal that reads:\n"
var day1_text = "\"Day 1:\nDuring the night I heard some strange noises.\nThey didn't sound like anything I heard before.\""
var day2_text = "\"Day 2:\nI could hear them tonight too. They seem to be \ngetting louder and closer.\""
var day3_text = "\"Day 3:\nThe strange noises don’t seem to go away. Perhaps \nI should go and investigate tomorrow.\""
var day4_text = "\"Day 4:\nI decided to go out tonight and see where the noises \nare coming from. I spotted some unusual activity \nnear the forest. I decided it was for the best not to \ngo further away and go back inside.\""
var day5_text_1 = "\"Day 5:\nThe village chief says we have to leave. He told us \nthe noises came from some creatures called… \n“zombies”? I’m not exactly sure if those are the"
var day5_text_2 = "creatures I saw last night, but the situation sounds \npretty serious. I even heard Albert got hurt by one\nof them.\nWe are set to leave tomorrow.\""

var journal_text = [day1_text, day2_text, day3_text, day4_text, day5_text_1, day5_text_2]
var journal_page
@onready var next_button = $Panel/next_button
@onready var prev_button = $Panel/prev_button

@onready var time_text = $time/time_text
var hours
var minutes
var elapse_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_music = music2
	current_music.playing = true
	
	background.visible = false
	text_panel.visible = false
	next_button.visible = false
	prev_button.visible = false
	
	journal_page = 0
	
	button_type = button_type_enum.NONE
	
	hours = 0
	minutes = 0
	elapse_time = 0
	
	var final_hour = str(hours)
	var final_minutes = str(minutes)
		
	if (hours < 10):
		final_hour = "0" + str(hours) 
	
	if (minutes < 10):
		final_minutes = "0" + str(minutes) 
	
	time_text.text = final_hour + ":" + final_minutes
	
	for i in range(0, len(text_array)):
		text_array[i].visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (elapse_time == 350):
		if (minutes == 59):
			minutes = 0
			if (hours == 23):
				hours = 0
			else:
				hours = hours + 1
		else:
			minutes = minutes + 1
		
		var final_hour = str(hours)
		var final_minutes = str(minutes)
		
		if (hours < 10):
			final_hour = "0" + str(hours) 
		
		if (minutes < 10):
			final_minutes = "0" + str(minutes) 
		
		time_text.text = final_hour + ":" + final_minutes
		
		elapse_time = 0
	else:
		elapse_time = elapse_time + 1
	
	if Input.is_action_just_pressed("inventory"):
		_on_backpack_pressed()
	
	if Input.is_action_just_pressed("exit"):
		_on_exit_pressed()
	
	for i in range(0, len(text_array)):
		if button_array[i].is_hovered():
			text_array[i].visible = true
		else:
			text_array[i].visible = false
	

##backpack
#func _on_pressed() -> void:
	#current_music.playing = false
	#
	#if (current_music == music1):
		#current_music = music2
	#else:
		#current_music = music1
	#
	#current_music.playing = true

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://start_menu.tscn")

func _on_music_pressed() -> void:
	current_music.playing = not current_music.playing

# CAND LE FAC PE ALEA GLOBALE ATUNCI FAC O VERIFICARE
# FA UN ARRAY SI CU ALEA GLOBALE
func _on_backpack_pressed() -> void:
	background.visible = not background.visible
	
	if (background.visible == false):
		text_panel.visible = false
		#item_text.visible = false

	#for i in range(0, len(text_array)):
		#text_array[i].visible = not text_array[i].visible
		#button_array[i].visible = not button_array[i].visible
	
	#text_panel.visible = not text_panel.visible


func _on_letter_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.LETTER):
		text_panel.visible = false
		button_type = button_type_enum.NONE
	else:
		item_text.text = "Note that reads:\n\"Please help us get rid of the zombies.\n                                                             Villagers\""
		text_panel.visible = true
		button_type = button_type_enum.LETTER

func _on_axe_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.AXE):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "Item useful for harvesting crops."
		text_panel.visible = true
		button_type = button_type_enum.AXE

func _on_seed_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.SEED):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "They can be used to plant new crops."
		text_panel.visible = true
		button_type = button_type_enum.SEED

func _on_journal_pressed() -> void:
	if (text_panel.visible and button_type == button_type_enum.JOURNAL):
			text_panel.visible = false
			button_type = button_type_enum.NONE
			next_button.visible = false
			prev_button.visible = false
	else:
		button_type = button_type_enum.JOURNAL
		next_button.visible = true
		prev_button.visible = true
		item_text.text = journal_message + journal_text[journal_page]
		text_panel.visible = true

func _on_next_button_pressed() -> void:
	if (journal_page == 5):
		journal_page = 0
	else:
		journal_page = journal_page + 1
	
	item_text.text = journal_message + journal_text[journal_page]

func _on_prev_button_pressed() -> void:
	if (journal_page == 0):
		journal_page = 5
	else:
		journal_page = journal_page - 1
	
	item_text.text = journal_message + journal_text[journal_page]

#func journal_text():
	#var day1_text = "“During the night I heard some strange noises. They didn't sound like anything I heard before.”"
	#var day2_text = "“I could hear them tonight too. They seem to be getting louder and closer.”"
	#var day3_text = "The strange noises don’t seem to go away. Perhaps I should go and investigate tomorrow."
	#var day4_text = "“I decided to go out tonight and see where the noises are coming from. I spotted some unusual activity near the forest. I decided it was for the best not to go further away and go back inside.”"
	#var day5_text = "“The village chief says we have to leave. He told us the noises came from some creatures called… “zombies”? I’m not exactly sure if those are the creatures I saw last night, but the situation sounds pretty serious. I even heard Albert got hurt by one of them.\nWe are set to leave tomorrow.”"
	#
	#var journal_text = [day1_text, day2_text, day3_text, day4_text, day5_text]
	#
	#return journal_text()

func _on_fire_crackers_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.FIRE_CRACKERS):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "They produce a loud noise."
		text_panel.visible = true
		button_type = button_type_enum.FIRE_CRACKERS

func _on_torch_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.TORTH):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "Source of light."
		text_panel.visible = true
		button_type = button_type_enum.TORTH

func _on_weapon_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.WEAPON):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "Item useful for self defense."
		text_panel.visible = true
		button_type = button_type_enum.WEAPON

func _on_ritual_pressed() -> void:
	next_button.visible = false
	prev_button.visible = false
	
	if (text_panel.visible and button_type == button_type_enum.RITUAL):
			text_panel.visible = false
			button_type = button_type_enum.NONE
	else:
		item_text.text = "???"
		text_panel.visible = true
		button_type = button_type_enum.RITUAL
