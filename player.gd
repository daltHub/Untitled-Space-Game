extends CharacterBody2D


@export var max_speed = 400
@export var acceleration = 50
@export var friction = 600 # slows down when ther is no movement input
@export var bullet_speed = 500 # 
@export var shoot_cooldown: float = 0.3 # time between bullet shots
@export var bullet_damage = 50 # damage done to enemy when bullet hits
@export var player_health = 100
@export var damage_cooldown = 1 # time in s of invulnerability
var screen_size # Size of the game window.
var input = Vector2.ZERO
var Bullet = preload("res://bullet.tscn")
var sprite : AnimatedSprite2D

@onready var shootCooldownTimer = $ShootCooldownTimer # timer to determine shoot cooldown (s)
@onready var shootSound = $ShootEffectPlayer # Sound effect for shooting
@onready var damageCooldownTimer = $DamageCooldownTimer
func _ready():
	add_to_group("player")
	sprite = $AnimatedSprite2D
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	var coll = player_movement(delta) # movement function returns collision info
	if coll:
		if coll.get_collider().is_in_group("mobs"):
			take_damage(coll.get_collider().contact_damage) # take damage equal to mobs damage stat
	# Shoot if not on cooldown
	if Input.is_action_pressed("shoot") and shootCooldownTimer.is_stopped() :
		shootCooldownTimer.start(shoot_cooldown)
		shoot()


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
		velocity += (input * acceleration)
		#velocity += (input * acceleration)
		velocity = velocity.limit_length(max_speed)
	#move_and_slide()
	var collision_data = move_and_collide(velocity*delta)
	return collision_data


func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b) # add bullet as child of main to stop rotation with player after instance
	b.speed = bullet_speed
	b.damage = bullet_damage
	b.transform = $Muzzle.global_transform # transform bullet to muzzle
	shootSound.play()


func take_damage(damage):
	if damageCooldownTimer.is_stopped():
		damageCooldownTimer.start(damage_cooldown)
		player_health -= damage
		if player_health <= 0:
			owner.game_over()
			get_tree().quit()

		print("player damage taken" + str(damage))
