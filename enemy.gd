extends CharacterBody2D
@export var enemySpeed = 400
#@onready var player = null
#@onready var player = get_node_or_null(get_parent().get_node("Player"))
@onready var player = get_parent().get_node("Player")
var motion = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
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
