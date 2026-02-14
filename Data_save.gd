extends Control

@onready var save_button = $Save_Button
@onready var question = $QuestionEdit
@onready var answer1 = $LineEdit
@onready var answer2 = $LineEdit2
@onready var answer3 = $LineEdit3
@onready var answer4 = $LineEdit4
@onready var dropdown = $OptionButton
@onready var back_button = $Back_Button
@onready var hint_button = $OptionButton2
var level_key = "Level_" + str(SignalBus.level)

# Called when the node enters the scene tree for the first time.
func _ready():
	save_button.button_down.connect(_on_save_button_pressed)
	back_button.button_down.connect(_on_back_button_pressed)


func save_questions():
	var file_path = "res://save_game.save"
	var data = {}

	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var json_text = file.get_as_text()
		file.close()

		data = JSON.parse_string(json_text)
		if data == null:
			data = {}

	var level_key = "Level_" + str(SignalBus.level)

	data[level_key] = {
		"Question": question.text,
		"Answer1": answer1.text,
		"Answer2": answer2.text,
		"Answer3": answer3.text,
		"Answer4": answer4.text,
		"Completed": false,
		"Correct_Answer": dropdown.get_item_text(dropdown.get_selected_id())
	}

	var file_write = FileAccess.open(file_path, FileAccess.WRITE)
	file_write.store_string(JSON.stringify(data))
	file_write.close()



func _on_save_button_pressed():
	save_questions()
	var style = save_button.get_theme_stylebox("normal").duplicate()
	style.bg_color = Color(0, 0.6, 0)
	save_button.add_theme_stylebox_override("normal", style)

	save_button.text = "Saved!"
	save_questions()

	await get_tree().create_timer(3).timeout
	save_button.text = "Save"
	save_button.remove_theme_stylebox_override("normal")

func _on_option_button_toggled(toggled_on):
	$OptionButton.clear()
	dropdown.add_item(answer1.text)
	dropdown.add_item(answer2.text)
	dropdown.add_item(answer3.text)
	dropdown.add_item(answer4.text)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")


