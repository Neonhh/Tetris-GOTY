extends CanvasLayer

signal start_game
signal game_over

var game_over = true

func _ready() -> void:
	show_game_title()
	$Score.hide()

func _process(delta: float) -> void:
	reset()

func show_game_over():
	$GameOver.text = "Game Over"
	$GameOver.show()
	$GameOverTimer.start()
	yield($GameOverTimer, "timeout")
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()
	show_game_title()
	
func show_game_title():
	$Title.text = "Tetris Hell"
	$Title.show()
	
	
func update_score(score):
	$Score/Value.text = str(score)
	
func reset_score():
	$Score/Value.text = "0000"

func _on_StartButton_pressed() -> void:
	emit_signal("start_game")
	game_over = false
	$StartButton.hide()
	$Title.hide()
	$Score.show()

func _on_GameOverTimer_timeout() -> void:
	$GameOver.hide()
	
func reset():
	if Input.is_action_just_pressed("gameover") and not game_over:
		emit_signal("game_over")
