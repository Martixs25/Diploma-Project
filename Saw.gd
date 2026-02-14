extends Node2D
signal death_collision

@export var speed: float = 100.0
@export var distance: float = 200.0
@export var horizontal: bool = true
@export var left_to_right: bool = true

var start_position: Vector2
var direction: int = 1

func _ready():
	start_position = position

func _process(delta):
	var movement
	if left_to_right:
		movement = speed * delta * direction
	else:
		movement = speed * delta * -direction

	if horizontal:
		position.x += movement
		if abs(position.x - start_position.x) >= distance:
			direction *= -1
	else:
		position.y += movement
		if abs(position.y - start_position.y) >= distance:
			direction *= -1


func _on_area_2d_body_entered(body):
		if body is Player:
			body.handle_death()
