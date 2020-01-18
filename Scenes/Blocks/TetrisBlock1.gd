extends KinematicBody2D

export var speed = 20.0
var direction = Vector2.DOWN
var collision
var stuck = false
var stuck_body
var type

func _ready():
	type = get_parent().ENTITY_TYPES.BLOCK

func _physics_process(delta):

		if stuck and stuck_body.direction.y != -1:
			position = stuck_body.get_node("Upside").get_global_position()
		
		collision = move_and_collide(direction * speed * delta)
		
		if collision: #Collision será null hasta que el objeto choque. En ese momento, se activa este if.
			collision_response(collision.get_collider())
		else:
			speed = 20.0
	

func collision_response(body):
	if body.name == "Player":
		stuck = true
		stuck_body = body
		
	
