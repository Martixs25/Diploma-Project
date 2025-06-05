extends Control
@onready var Question = $Question
@onready var Answer1 = $Answer1
@onready var Answer2 = $Answer2
@onready var Answer3 = $Answer3
@onready var Answer4 = $Answer4
var level_key = "Level_" + str(SignalBus.level)
@onready var label = $Label
var correct_answer : String
# Called when the node enters the scene tree for the first time.
func _ready():
	load_question()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_question():
	var file_path = "res://save_game.save"
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var json = file.get_line()
		file.close()
		var data = JSON.parse_string(json)
		print(data)
		if data != null:
			print(level_key)
			var level_data = data.get(level_key, {})
			print(level_data)
			correct_answer = level_data.get("Correct_Answer", "")
			print(correct_answer)
			Question.text = level_data.get("Question", "")
			Answer1.text = level_data.get("Answer1", "")
			Answer2.text = level_data.get("Answer2", "")
			Answer3.text = level_data.get("Answer3", "")
			Answer4.text = level_data.get("Answer4", "")
			
		else: print("Failed to parse file")
	else: print("Save file not found")

func _on_answer_1_pressed():
	check_answer(Answer1) 
	disable_buttons()


func _on_answer_2_pressed():
	check_answer(Answer2)
	disable_buttons()

func _on_answer_3_pressed():
	check_answer(Answer3)
	disable_buttons()

func _on_answer_4_pressed():
	check_answer(Answer4) 
	disable_buttons()

func disable_buttons():
	Answer1.disabled = true
	Answer2.disabled = true
	Answer3.disabled = true
	Answer4.disabled = true
	
func check_answer(button: Button):
	if button.text == correct_answer: 
		print("Correct")
		button.modulate = Color(0, 1, 0)  # green
		Question.visible = false
		label.visible = true
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
				data[level_key]["Completed"] = true
				print(data)
				var save = JSON.stringify(data)
				print("save=", save)
				file_write.store_line(save)
				file_write.close()

		else: print("Save file not found")

		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://main_menu/level_select.tscn")
	else: 
		print("Incorrect")
		button.modulate = Color(1, 0, 0)  # green
		await get_tree().create_timer(1.5).timeout
		button.modulate = Color(1, 1, 1)  # reset
