extends Area2D

@export var speed = 1750
@export var damage = 50

@export var bullet_range = 200
var distance_travelled = 0

func _ready():
	pass
	
	
func _physics_process(delta):
	position += transform.x * speed * delta
	distance_travelled += speed*delta
	if distance_travelled>bullet_range:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.take_damage(damage)

	queue_free()


