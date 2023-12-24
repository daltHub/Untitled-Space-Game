extends CharacterBody2D


@export var max_speed = 800
@export var acceleration = 1800
@export var friction = 600
@export var bullet_speed = 500 # unused var for bullet speed 
@export var shootCooldown: float = 0.3 
@export var bulletDamage = 50

var screen_size # Size of the game window.
var input = Vector2.ZERO

var Bullet = preload("res://bullet.tscn")

@onready var shootCooldownTimer = $ShootCooldownTimer # timer to determine shoot cooldown (s)
@onready var shootSound = $ShootEffectPlayer # Sound effect for shooting

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
	b.speed = bullet_speed
	b.damage = bulletDamage
	b.transform = $Muzzle.global_transform
	shootSound.play()
	
	


func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	player_movement(delta)
	# Shoot if not on cooldown
	if Input.is_action_pressed("shoot") and shootCooldownTimer.is_stopped() :
		shootCooldownTimer.start(shootCooldown)
		shoot()



