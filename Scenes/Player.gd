extends KinematicBody2D

export(float) var max_speed = 350.0

var motion = Vector2.ZERO
var direction
var target_pos = Vector2()
var current_direction = Vector2()
var type
var velocity

var is_moving = false

onready var grid = get_parent()
func _ready() -> void:
	
	type = grid.ENTITY_TYPES.PLAYER
	$AnimatedSprite.play("default")

func _physics_process(delta: float) -> void:
	
	direction = get_direction()   #Obtiene vetores directores de norma 1
	                                #También revisa si las teclas están presionadas 
	
	if !is_moving and direction != Vector2(0,0):
		current_direction = direction
		if grid.cell_is_vacant(self) :
			
			target_pos = grid.update_child_pos(self)
			is_moving = true
	elif is_moving:
		
		velocity = current_direction*max_speed*delta
		
		move_and_slide(velocity)
		
		var pos = position
		var distance = Vector2(abs(target_pos.x - pos.x),abs(target_pos.y - pos.y))
		
		if abs(velocity.x) > distance.x:
			
			
			velocity.x = distance.x * current_direction.x
			is_moving = false
		if abs(velocity.y) > distance.y:
			
			velocity.y = distance.y * current_direction.y
			is_moving = false
	
	
	
	
	
	
		#Obtén la dirección y velocidad del movimiento.
func get_direction():
	#Da 1 o -1 dependiendo de la dirección, 0 si la dirección no se puede definir (ninguna o ambas teclas presionadas)
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#get_action_strength es lo mismo que un int(bool), devuelve 1 si la tecla está presionada, 0 si no. (teclas no análogas)
	return direction.normalized()
