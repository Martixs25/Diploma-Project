extends Control

@onready var level_1_button = $Level1
@onready var level_2_button = $Level2
@onready var level_1 = preload("res://Levels/level1.tscn") as PackedScene
@onready var level_2 = preload("res://Levels/level2.tscn") as PackedScene
@onready var data_save = preload("res://main_menu/question_editor.tscn") as PackedScene
var style = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.


func _ready():
	var file = FileAccess.open("res://save_game.save", FileAccess.READ)
	var json = file.get_line()
	var data = JSON.parse_string(json)
	style.bg_color = Color(0,0.5,0)
	
	#if data["Level_1"]["Completed"] == true and SignalBus.mode == "play": level_1_button.add_theme_stylebox_override("normal", style)
	#elif data["Level_1"] == false : pass
	level_1_button.button_down.connect(on_level_1_pressed)
	
	#if data["Level_2"]["Completed"] == true and SignalBus.mode == "play": level_2_button.add_theme_stylebox_override("normal", style)
	level_2_button.button_down.connect(on_level_2_pressed)
	

	file.close()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func on_level_1_pressed(): 
	if SignalBus.mode == "play":
		get_tree().change_scene_to_packed(level_1)
	elif SignalBus.mode == "edit":
		get_tree().change_scene_to_packed(data_save)
	SignalBus.level = 1


func on_level_2_pressed():
	print("print")
	if SignalBus.mode == "play":
		get_tree().change_scene_to_packed(level_2)
	elif SignalBus.mode == "edit":
		get_tree().change_scene_to_packed(data_save)
	SignalBus.level = 2
