extends Control

@onready var level_1 = $Button
@onready var start_level = preload("res://level1.tscn") as PackedScene
@onready var data_save = preload("res://main_menu/question_editor.tscn") as PackedScene
var style = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.


func _ready():
	var file = FileAccess.open("res://save_game.save", FileAccess.READ)
	var json = file.get_line()
	var data = JSON.parse_string(json)
	style.bg_color = Color(0,0.5,0)
	
	if data["Level_1"]["Completed"] == true and SignalBus.mode == "play": level_1.add_theme_stylebox_override("normal", style)
	level_1.button_down.connect(on_level_1_pressed)
	
	

	file.close()

func on_level_1_pressed(): 
	if SignalBus.mode == "play":
		get_tree().change_scene_to_packed(start_level)
	elif SignalBus.mode == "edit":
		get_tree().change_scene_to_packed(data_save)
	SignalBus.level = 1

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
