class_name BaseCollectableEntity
extends Area2D

@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var animation_player = $AnimationPlayer as AnimationPlayer

@export var collectable_resource : BaseCollectableResource = null

signal collect_entity

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("collect_entity", on_collect)
	sprite_2d.texture = collectable_resource.collectable_texture
	handle_animation()

func on_collect() -> void:
	SignalBus.emit_collect_entity(collectable_resource)
	queue_free()

func handle_animation() -> void: 
	match collectable_resource.collectable_type:
		"":
			return
		"coin":
			if collectable_resource.value == 1:
				animation_player.play("coin 1")
