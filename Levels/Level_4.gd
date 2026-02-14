
extends Node2D

@export var level_id : int
@export var level_start_pos : Node2D
@onready var pause_menu = $CanvasLayer/Control/Pause_Menu

var paused = false

func _ready():
	pause_menu.position = Vector2(240,136) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
			
	if Input.is_action_just_pressed("pause"):
		paused_menu()



func paused_menu() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
