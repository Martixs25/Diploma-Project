extends Node2D

var state = ""
var player_in_area = false
# Called when the node enters the scene tree for the first time.
func _ready():
	

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if player_in_area:
		
	#animation goes here
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("Player"):
		player_in_area = true


func _on_area_2d_body_exited(body):
	if body.has_method("Player"):
		player_in_area = false
