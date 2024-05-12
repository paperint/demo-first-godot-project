extends RigidBody2D

func _ready():
	var enemy_names = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var select = enemy_names[2]
	# Animation
	$AnimatedSprite2D.play(select)
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() #ลบ Node
