extends KinematicBody2D

export (int) var max_speed = 200

var velocity_direction = Vector2()

func _ready() -> void:
	$AnimatedSprite.play("default")

func _physics_process(delta: float) -> void:
	#Movimiento del Jugador
	velocity_direction = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity_direction.x += 1
	if Input.is_action_pressed("move_left"):
		velocity_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity_direction.y += 1
	if Input.is_action_pressed("move_up"):
		velocity_direction.y -= 1
	if velocity_direction.length() > 0:
		velocity_direction = velocity_direction.normalized() * max_speed
	
	move_and_slide(velocity_direction)