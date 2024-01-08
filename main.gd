extends Node
@onready var health_bar = $HUD/HealthBar
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_health = player.player_health
	health_bar.set_value_no_signal(player_health)
	pass

func new_game():
	get_tree().reload_current_scene()
	pass

func game_over():
	print("Game Over CAlled")
	new_game()
	pass
