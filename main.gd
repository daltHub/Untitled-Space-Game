extends Node
@onready var health_bar = $HUD/HealthBar
@onready var player = $Player
var enemy = preload("res://enemy.tscn")
var level_time_limit = 60.0
var level_timer : Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemySpawnTimer.start(	)
	# set up level timer
	level_timer.one_shot = true
	level_timer.wait_time = level_time_limit
	level_timer.autostart = false
	level_timer.timeout.connect(_on_level_timer_timeout)
	add_child(level_timer)
	level_timer.start()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_health = player.player_health
	health_bar.set_value_no_signal(player_health)
	$HUD/LevelTimerLabel.text = str(int(level_timer.time_left))


func new_game():
	get_tree().reload_current_scene()
	pass

func game_over():

	new_game()
	pass

func _on_level_timer_timeout():
	new_game()

func _on_enemy_spawn_timer_timeout():
	var mob = enemy.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("EnemySpawnPath/EnemySpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	pass # Replace with function body.

