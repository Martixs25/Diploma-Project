extends Node

signal collect_entity(collectable_entity_resource : BaseCollectableResource)

signal on_coin_collected(value : int)

signal update_coin_label(value : int)

func emit_collect_entity(collectable_entity_resource : BaseCollectableResource) -> void:
	collect_entity.emit(collectable_entity_resource)

func emit_on_coin_collected(value : int) -> void:
	on_coin_collected.emit(value)
	
func emit_update_coin_label(value : int) -> void:
	update_coin_label.emit(value)
