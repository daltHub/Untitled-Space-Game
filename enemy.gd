extends CharacterBody2D
@export var enemy_speed = 400
@export var enemy_health = 100
@export var enemy_damage = 20
@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("mobs") # mobs tag allows damage by bullets
	
func deal_damage():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = player.global_position
	var target_position = (player_position-position).normalized()
	look_at(player_position)
	velocity = target_position*enemy_speed*delta
	#position += transform.x * enemy_speed * delta
	move_and_collide(velocity)

	
func take_damage(damage):
	print("damage occured: " + str(damage))
	enemy_health -= damage
	if enemy_health <= 0 :
		die()



func die():
	queue_free()
