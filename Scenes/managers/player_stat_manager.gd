class_name PLayerStatManager
extends Node

var current_coin_amount : int = 0
var current_coin_max : int = 99
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("on_coin_collected", on_coin_collected)
	pass # Replace with function body.

func on_coin_collected(value : int) -> void:
	current_coin_amount += value
	
	if current_coin_amount > current_coin_max:
		current_coin_amount = current_coin_max
	
	SignalBus.emit_update_coin_label(current_coin_amount)
