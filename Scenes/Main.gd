extends Node2D

func new_game() -> void:
	$GUI.reset_score()
	
func game_over() -> void:
	$GUI.show_game_over()
	
onready var spawner = get_node("Grid/Spawner")
onready var tetrisblock = get_node("Grid/TetrisBlock1/ResetBlock")
onready var player = get_node("Grid/Player/Reset")

func _ready():
	$GUI.connect("game_over", spawner, "on_game_over")
	$GUI.connect("start_game", spawner, "on_start_game")
	$GUI.connect("game_over", tetrisblock, "on_game_over")
	$GUI.connect("start_game", tetrisblock, "on_start_game")
	$GUI.connect("start_game", player, "on_start_game")
	$GUI.connect("game_over", player, "on_game_over")