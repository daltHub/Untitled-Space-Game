extends CharacterBody2D
@export var enemySpeed = 400
@export var enemyHealth = 100
@onready var player = get_parent().get_node("Player")
var motion = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("mobs")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = player.global_position
	var target_position = (player_position-position).normalized()
	look_at(player_position)
	velocity += target_position*enemySpeed*delta
	move_and_slide()
	#motion += position.direction_to(player.position)
	#pass
	
func take_damage(damage):
	print("damage occured: " + str(damage))
	enemyHealth -= damage
	if enemyHealth <= 0 :
		die()
	

func die():
	queue_free()
