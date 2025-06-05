extends Control

@onready var save_button = $Save_Button
@onready var question = $QuestionEdit
@onready var answer1 = $LineEdit
@onready var answer2 = $LineEdit2
@onready var answer3 = $LineEdit3
@onready var answer4 = $LineEdit4
@onready var dropdown = $OptionButton
@onready var back_button = $Back_Button


# Called when the node enters the scene tree for the first time.
func _ready():
	save_button.button_down.connect(_on_save_button_pressed)
	back_button.button_down.connect(_on_back_button_pressed)

func save_questions():
	var save_data = {
		"Level_" + str(SignalBus.level):{
		"Question": question.text,
		"Answer1": answer1.text,
		"Answer2": answer2.text,
		"Answer3": answer3.text,
		"Answer4": answer4.text,
		"Completed": false,
		"Correct_Answer" : dropdown.get_item_text(dropdown.get_selected_id())}
	}
	
	var file = FileAccess.open("res://save_game.save", FileAccess.WRITE)
	var json = JSON.stringify(save_data)
	file.store_line(json)
	file.close()


func _on_save_button_pressed():
	save_questions()


func _on_option_button_toggled(toggled_on):
	$OptionButton.clear()
	dropdown.add_item(answer1.text)
	dropdown.add_item(answer2.text)
	dropdown.add_item(answer3.text)
	dropdown.add_item(answer4.text)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

