class_name CollectableManager
extends Node

var current_coin_count : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("collect_entity", on_entity_collected)
	
func on_entity_collected(collectable_resource : BaseCollectableResource):
	match collectable_resource.collectable_type:
		"":
			print("ERROR NO TYPE FOUND")
			return
		"coin":
			SignalBus.emit_on_coin_collected(collectable_resource.value)
