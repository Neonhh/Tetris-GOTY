extends "res://Scenes/type.gd" #el tipo es usado para marcar celdas

var direction = Vector2.DOWN
onready var grid = get_parent()

func _ready():
	print(str(position))

func _on_Timer_timeout():
	print(str(position))
	var target_position = grid.request_move(self, direction)
	if target_position:
		
		move_to(target_position)
		$Tween.start()

func move_to(target):
	set_process(false)
	$Tween.interpolate_property($Sprite,"position", -direction*16, Vector2(), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target
	
	set_process(true)


