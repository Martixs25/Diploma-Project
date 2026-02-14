extends Node2D
@onready var main_menu = preload("res://main_menu/main_menu.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_packed(main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
