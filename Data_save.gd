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
	hint_button.set_text("Something")

func save_questions():
	var previous_data : String 
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
	var file_path = "res://save_game.save"
	
	if FileAccess.file_exists(file_path): #getting the current save file
		print("open_file")
		var file = FileAccess.open("res://save_game.save", FileAccess.READ)
		var json = file.get_line()
		var data = JSON.parse_string(json)
		var level_data = data.get(level_key, {})
		file.close()
			
		if false in level_data.values() : #checking if the level has been completed
			var file_write = FileAccess.open("res://save_game.save", FileAccess.WRITE)
			data[level_key] = save_data
			print(data)
			var save = JSON.stringify(data)
			print("save=", save)
			file_write.store_line(save)
			file_write.close()

	else: print("Save file not found")


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

func _on_option_button_2_toggled(toggled_on):
	hint_button.set_text("")
	hint_button.clear()
	hint_button.add_item("No hint.")
	hint_button.add_item("50/50 (Choose 2 correct answers)")
	hint_button.add_item("Give a clue.")
