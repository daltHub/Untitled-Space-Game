extends CharacterBody2D


var max_speed = 800
var acceleration = 1800
var friction = 600
var screen_size # Size of the game window.
var input = Vector2.ZERO
var bullet_speed = 2000
var Bullet = preload("res://bullet.tscn")
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

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform



func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	player_movement(delta)
	if Input.is_action_pressed("shoot"):
		shoot()



