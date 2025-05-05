extends Control

@onready var level_1 = $Button
@onready var start_level = preload("res://main.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.

func _ready():
	level_1.button_down.connect(on_level_1_pressed)

func on_level_1_pressed(): 
	get_tree().change_scene_to_packed(start_level)
