extends Node2D

@export var enemy_scene:PackedScene

var score:int

func new_game():
	get_tree().call_group("enemies","queue_free")
	score = 0
	$Player.create_player($SpawnPlayer.position)
	$GAME_UI.display_score(score)
	$GAME_UI.display_status("Ready !")
	$StartTimer.start()


func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
	score = 0


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	# spawnEnemy
	var spawnlocation = $EnemyPath/SpawnEnemy
	# position
	spawnlocation.progress_ratio = randf() # 0-1
	enemy.position = spawnlocation.position
	# rotation
	var direction = spawnlocation.rotation + PI / 2
	direction += randf_range(-PI/4, PI /4)
	enemy.rotation = direction
	# velocity
	var velocity = Vector2(randf_range(200.0,250.0),0.0)
	enemy.linear_velocity = velocity.rotated(direction)
	
	add_child(enemy)


func _on_score_timer_timeout():
	score += 1
	$GAME_UI.display_score(score)
	
func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$GAME_UI.display_gameover()
