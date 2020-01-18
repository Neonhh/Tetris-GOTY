extends KinematicBody2D

export(float) var max_speed = 350.0

var motion = Vector2.ZERO
var direction
var velocity_direction = Vector2()

func _ready() -> void:
	$AnimatedSprite.play("default")

func _physics_process(delta: float) -> void:
	
		direction = get_direction()   #Obtiene vetores directores de norma 1
		                                  #También revisa si las teclas están presionadas 
	
		if direction == Vector2.ZERO:           #Si no hay teclas presionadas, desacelera.
			motion = Vector2.ZERO
		else:                                  #Si las hay, acelera.
			motion = direction * max_speed
		
		motion = move_and_slide(motion)
	
		#Obtén la dirección y velocidad del movimiento.
func get_direction():
	#Da 1 o -1 dependiendo de la dirección, 0 si la dirección no se puede definir (ninguna o ambas teclas presionadas)
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#get_action_strength es lo mismo que un int(bool), devuelve 1 si la tecla está presionada, 0 si no. (teclas no análogas)
	return direction.normalized()
