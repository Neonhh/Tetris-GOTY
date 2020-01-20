extends Node2D

func on_game_over():
	print("ESTO LO ESCUCHO")
	yield(get_tree().create_timer(2),"timeout")
	get_parent().queue_free()
	print(get_parent().name)