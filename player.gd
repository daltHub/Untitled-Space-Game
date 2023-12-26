extends CharacterBody2D


@export var max_speed = 400
@export var acceleration = 1000
@export var friction = 600 # slows down when ther is no movement input
@export var bullet_speed = 500 # 
@export var shoot_cooldown: float = 0.3 # time between bullet shots
@export var bullet_damage = 50 # damage done to enemy when bullet hits
var screen_size # Size of the game window.
var input = Vector2.ZERO
var Bullet = preload("res://bullet.tscn")

@onready var shootCooldownTimer = $ShootCooldownTimer # timer to determine shoot cooldown (s)
@onready var shootSound = $ShootEffectPlayer # Sound effect for shooting

func _ready():
	add_to_group("player")
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
		#velocity += (input * acceleration)
		velocity = velocity.limit_length(max_speed)
	#move_and_slide()
	var collision_data = move_and_collide(velocity*delta)
	return collision_data



func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.speed = bullet_speed
	b.damage = bullet_damage
	b.transform = $Muzzle.global_transform # 
	shootSound.play()


func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	player_movement(delta)
	# Shoot if not on cooldown
	if Input.is_action_pressed("shoot") and shootCooldownTimer.is_stopped() :
		shootCooldownTimer.start(shoot_cooldown)
		shoot()
		



