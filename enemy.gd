extends CharacterBody2D
@export var enemy_speed = 200
@export var enemy_health = 100
@export var contact_damage = 20
@export var hitEffectTime = 0.1
@onready var player = get_parent().get_node("Player")
@onready var hitEffectTimer = $HitEffectTimer
var sprite : Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("mobs") # mobs tag allows damage by bullets
	sprite = $Sprite2D
	
func deal_damage(damage):
	player.take_damage(damage)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = player.global_position
	var target_position = (player_position-position).normalized()
	look_at(player_position)
	velocity = target_position*enemy_speed*delta
	#position += transform.x * enemy_speed * delta
	#var collision = move_and_collide(velocity)
	move_and_collide(velocity)
	#if collision:
		#var collider = collision.get_collider()
		#if collider == player:
			#print("collider is players")
			#deal_damage(contact_damage)
	if ! hitEffectTimer.is_stopped():
		sprite.modulate = Color(0.545098, 0, 0, 0.5)
	else:
		sprite.modulate = Color.WHITE
	
func take_damage(damage):
	print("damage occured: " + str(damage))
	enemy_health -= damage
	hitEffectTimer.start(hitEffectTime)
	
	if enemy_health <= 0 :
		die()


func die():
	queue_free()
