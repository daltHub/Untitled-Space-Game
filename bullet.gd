extends Area2D

var speed = 1750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	print("collision")
	queue_free()


func _on_body_entered(body):
	queue_free()
	pass # Replace with function body.
