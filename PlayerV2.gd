class_name Player
extends CharacterBody2D

@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var animation_player = $AnimationPlayer as AnimationPlayer
@export var move_speed : float = 300.0
@export var jump_speed : float = 400.0
@export var fall_speed : float = 400.0
@export var sprint_speed : float = 300.0
@export var dash_speed : float = 100.0
@export var direction : bool
@export var double_jump : bool = true
@export var falling_speed : float
var can_control : bool = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
const GRAVITY : float = 1000.0

func _ready():
	pass

func _physics_process(delta):
	
	if not can_control: return
	# Add the gravity.
	apply_gravity(delta)

	handle_movement()
	
	handle_jump()
	
	move_and_slide()
	
	flip_character()
	
	handle_animation()
	
	handle_dash()
	



func apply_gravity(delta : float) -> void:
	falling_speed = GRAVITY*delta
	velocity.y += GRAVITY*delta
	
func handle_movement() -> void: 
	var movement_direction : float = Input.get_axis("move_left", "move_right")
	var sprint_active : bool = false
	
	velocity.x = 0.0
	
	if movement_direction < 0:
		velocity.x = -move_speed
	if movement_direction > 0:
		velocity.x = move_speed
		
	if Input.is_action_just_pressed("sprint", sprint_active == false):
		sprint_active = true
		move_speed += sprint_speed
	elif Input.is_action_just_released("sprint", sprint_active == true):
		sprint_active = false
		move_speed -= sprint_speed
			
			

	
func handle_jump() -> void:
	
	var jump_active : bool = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and double_jump:
		velocity.y = -jump_speed
		double_jump = true
		jump_active = true
		print (double_jump)


	elif is_on_floor(): 
		double_jump = true
		jump_active = false

	elif Input.is_action_just_pressed("jump") and double_jump and is_on_floor() == false:
		velocity.y = -jump_speed
		double_jump = false
		print (double_jump)

	clampf(velocity.y, jump_speed, fall_speed)
		
func flip_character() -> void: 
	if velocity.x != 0:
		$Sprite2D.flip_v = false
		$Sprite2D.flip_h = velocity.x > 0

func handle_animation() -> void:
	if velocity == Vector2.ZERO:
		animation_player.play("idle")
	
	if velocity.x != 0 and velocity.y == 0:
		animation_player.play("run")
	
	if velocity.y != 0:
		animation_player.play("jump")

func handle_dash() -> void:
	var movement_direction : float = Input.get_axis("move_left", "move_right")

	
	if movement_direction != 0 and movement_direction < 0:
		direction = false
	elif movement_direction != 0 and movement_direction > 0:
		direction = true

	if Input.is_action_just_pressed("dash"):
		if direction == false:
			position.x = position.x - dash_speed
		elif direction == true:
			position.x = position.x + dash_speed

func handle_death() -> void:
	print("Player died")
	visible = false
	can_control = false
	await get_tree().create_timer(1).timeout
	
	reset_player()
	
func reset_player() -> void:
	global_position = Vector2(250, 300)
	visible = true
	can_control = true
	
