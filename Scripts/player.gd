extends Area2D

var speed:int = 300
var display_size
signal take_damage

func _ready():
	display_size = get_viewport_rect().size
	hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO #(x,y)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	# Animation เคลื่อนไหว
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play("cat_idle")
	
	# เคลื่อนที่
	position += velocity * delta
	
	# ตั้งค่าขอบเขตการเคลื่อนที่
	position = position.clamp(Vector2.ZERO,display_size)
	
	# Flip Animation
	if velocity.x != 0 :
		$AnimatedSprite2D.animation = "cat_run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.flip_v = false # ไม่สามารถพลิกตัวแนวตั้งได้
	
	if velocity.y != 0 :
		$AnimatedSprite2D.animation = "cat_run"
	


func _on_body_entered(body):
	print('ผู้เล่นโดนชน')
	hide()
	take_damage.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	
func create_player(point):
	position = point
	show()
	$CollisionShape2D.disabled = false
