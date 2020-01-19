extends "res://Scenes/type.gd" #el tipo es usado para marcar celdas

var direction = Vector2.DOWN
var sticky_body
var prev_sticky_pos 
var landed = false
onready var grid = get_parent()

func _ready():
	grid.get_node("Player").connect("moved",self,"_on_Player_moved")

func _on_Timer_timeout():
	var target_position = grid.request_move(self, direction)
	if target_position:
		move_to(target_position)
		$Tween.start()
	
	else:
		get_sticky_body()
	
func move_to(target):	
	
	var move_direction = (target - position).normalized()
	
	$Tween.interpolate_property($Sprite,"position", -move_direction*16, Vector2(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	yield($Tween, "tween_started")
	position = target
	
	yield($Tween, "tween_completed")

func get_sticky_body():
	var cell_start = grid.world_to_map(position)
	var target_position = cell_start + direction
	var sticky_body = grid.get_cell_pawn(target_position)
	if !sticky_body:
		sticky_body = grid.get_cell_pawn(target_position, ENTITY_TYPES.BLOCK)
	
	$Timer.stop()
	landed = true

func _on_Player_moved(p_direction):
	
	if landed:
		direction = p_direction
		var target = grid.request_move(self,direction)
		if target:
			move_to(target)
			$Tween.start()
