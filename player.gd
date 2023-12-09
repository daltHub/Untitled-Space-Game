extends CharacterBody2D


var max_speed = 400
var acceleration = 1000
var friction = 600
var screen_size # Size of the game window.
var input = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func get_movement_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()
	
	
func player_movement(delta):
	input = get_movement_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity-=velocity.normalized() * (friction*delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()
	return


func _physics_process(delta):
	look_at(get_global_mouse_position())
	player_movement(delta)



