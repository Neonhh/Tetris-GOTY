extends "res://Scenes/type.gd"

var direction



onready var grid = get_parent()
func _ready() -> void:
	$AnimatedSprite.play("default")

func _physics_process(delta: float) -> void:
	
	direction = get_direction()   #Obtiene vetores directores de norma 1
	                                #También revisa si las teclas están presionadas 
	if not direction:
		return
	
	var target_position = grid.request_move(self, direction)
	
	if target_position:
		move_to(target_position)
		$Tween.start()
	
		#Obtén la dirección y velocidad del movimiento.
func get_direction():
	#Da 1 o -1 dependiendo de la dirección, 0 si la dirección no se puede definir (ninguna o ambas teclas presionadas)
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#get_action_strength es lo mismo que un int(bool), devuelve 1 si la tecla está presionada, 0 si no. (teclas no análogas)
	return direction.normalized()

func move_to(target_position):
	set_process(false)
	var move_direction = (target_position - position).normalized()
	position = target_position
	$Tween.interpolate_property($Sprite,"position", - move_direction * 32, Vector2(), 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	
	yield($Tween, "tween_completed")
	set_process(true)
	