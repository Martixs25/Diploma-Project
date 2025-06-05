class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button
@onready var level_select = preload("res://main_menu/level_select.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_options_pressed)
	print("something")
	
func on_start_pressed() -> void:
	SignalBus.mode = "play"
	get_tree().change_scene_to_packed(level_select)
	
func on_exit_pressed() -> void:
	get_tree().quit()

func on_options_pressed() -> void: 
	SignalBus.mode = "edit"
	get_tree().change_scene_to_packed(level_select)
