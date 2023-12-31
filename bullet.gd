extends Area2D

@export var speed = 1750
@export var damage = 50

func _ready():
	#self.speed = speed
	self.damage = damage
	
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.take_damage(damage)

	queue_free()
