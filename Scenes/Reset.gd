extends Node2D

var game_over = true

func _ready() -> void:
	get_parent().hide()


func on_start_game():
	get_parent().show()
	game_over = false
	get_parent().global_position = Vector2(382,515)

func on_game_over():
	get_parent().hide()
	game_over = true
	yield(get_tree().create_timer(2),"timeout")
	get_parent().hide()