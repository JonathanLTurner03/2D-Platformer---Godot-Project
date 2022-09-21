extends KinematicBody2D

var gravity = 1000
var velocity = Vector2.ZERO
var max_horizontal_speed = 140
var horizontal_acceleration = 2000
var jump_speed = 360
var jump_termination_multiplier = 4

func _ready():
	pass
	
func _process(delta):
	var moveVector = get_movement_vector()
	set_x_velocity(moveVector, delta)
	set_y_velocity(moveVector, delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	
func get_movement_vector():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return moveVector

func set_x_velocity(moveVector, delta):
	velocity.x += moveVector.x * horizontal_acceleration * delta
	if (moveVector.x == 0):
		velocity.x = lerp(0, velocity.x, pow(2, -15 * delta))
		
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

func set_y_velocity(moveVector, delta):
	if (moveVector.y < 0 && is_on_floor()):
		velocity.y = moveVector.y * jump_speed
		
	if (velocity.y < 0 && !Input.is_action_pressed("jump")):
		velocity.y += gravity * jump_termination_multiplier * delta
	else: 
		velocity.y += gravity * delta
