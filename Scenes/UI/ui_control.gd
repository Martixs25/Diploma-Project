class_name UIControl
extends Control
@export var coin_label : Label = null

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("update_coin_label", on_coin_label_update)
	coin_label.text = str(0)
	
	pass # Replace with function body.

func on_coin_label_update(value : int) -> void:
	coin_label.text = str(value)

