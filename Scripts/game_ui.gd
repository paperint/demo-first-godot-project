extends CanvasLayer

signal start_game
# แสดงผลคะแนน
func display_score(score):
	$Score_Label.text = str(score)


func _on_button_pressed():
	$Start_Button.hide()
	start_game.emit()

func display_status(message):
	$Status_Label.text = message
	$Status_Label.show()
	$Status_Timer.start()


func _on_status_timer_timeout():
	$Status_Label.hide()

func display_gameover():
	display_status("Game Over :(")
	await $Status_Timer.timeout
	$Status_Label.text = "Brave CAT"
	$Status_Label.show()
	$Start_Button.show()
