extends Control

@onready var level_1_button = $Level1
@onready var level_2_button = $Level2
@onready var level_3_button = $Level3
@onready var level_4_button = $Level4
@onready var level_1 = preload("res://Levels/Level_1.tscn") as PackedScene
@onready var level_2 = preload("res://Levels/Level_2.tscn") as PackedScene
@onready var level_3 = preload("res://Levels/Level_3.tscn") as PackedScene
@onready var level_4 = preload("res://Levels/Level_4.tscn") as PackedScene
@onready var data_save = preload("res://main_menu/question_editor.tscn") as PackedScene
@onready var main_menu = preload("res://main_menu/main_menu.tscn") as PackedScene
var style = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.


func _ready():
	get_tree().paused = false
	var file = FileAccess.open("res://save_game.save", FileAccess.READ)
	if file == null:
		print("The file cannot be opened.")
		return

	var json_text = file.get_as_text()
	file.close()

	var data = JSON.parse_string(json_text)
	if data == null:
		print("Error in parsing the JSON.")
		return

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0.5, 0)

	if SignalBus.mode == "play":
		if data.has("Level_1") and data["Level_1"].has("Completed") and data["Level_1"]["Completed"] == true:
			level_1_button.add_theme_stylebox_override("normal", style)

		if data.has("Level_2") and data["Level_2"].has("Completed") and data["Level_2"]["Completed"] == true:
			level_2_button.add_theme_stylebox_override("normal", style)
			
		if data.has("Level_3") and data["Level_3"].has("Completed") and data["Level_3"]["Completed"] == true:
			level_3_button.add_theme_stylebox_override("normal", style)
			
		if data.has("Level_4") and data["Level_4"].has("Completed") and data["Level_4"]["Completed"] == true:
			level_4_button.add_theme_stylebox_override("normal", style)	

			
	level_1_button.button_down.connect(on_level_1_pressed)
	level_2_button.button_down.connect(on_level_2_pressed)
	level_3_button.button_down.connect(_on_level_3_pressed)
	level_4_button.button_down.connect(_on_level_4_pressed)
	file.close()


func _on_back_button_pressed():
	get_tree().change_scene_to_packed(main_menu)
	

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


func _on_level_3_pressed():
	print("print")
	if SignalBus.mode == "play":
		get_tree().change_scene_to_packed(level_3)
	elif SignalBus.mode == "edit":
		get_tree().change_scene_to_packed(data_save)
	SignalBus.level = 3


func _on_level_4_pressed():
	print("print")
	if SignalBus.mode == "play":
		get_tree().change_scene_to_packed(level_4)
	elif SignalBus.mode == "edit":
		get_tree().change_scene_to_packed(data_save)
	SignalBus.level = 4
