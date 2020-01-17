extends KinematicBody2D

export var speed = 200.0
var direction = Vector2.DOWN
var collision
var stuck = false
var stuck_body

func _physics_process(delta):

		if stuck:
			speed = stuck_body.max_speed
			direction = stuck_body.direction
		
		collision = move_and_collide(direction * speed * delta)
		
		if collision: #Collision será null hasta que el objeto choque. En ese momento, se activa este if.
			collision_response(collision.get_collider())
	

func collision_response(body):
	if body.name == "Player":
		stuck = true
		stuck_body = body
	
