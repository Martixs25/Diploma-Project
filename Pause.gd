extends Control
@onready var level_select = $VBoxContainer/Select_Level
@onready var level_select_tcsn = preload("res://main_menu/level_select_2.tscn") as PackedScene
@onready var main_menu = preload("res://main_menu/main_menu.tscn") as PackedScene
@onready var main = $"../../../"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#level_select.button_down.connect(on_level_select_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resume_pressed():
	main.paused_menu()

func _on_select_level_pressed():
	SignalBus.mode = "play"
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_packed(level_select_tcsn)

func _on_main_menu_pressed():
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)
