extends KinematicBody2D

export var speed = 20.0
var direction = Vector2.DOWN
var collision
var stuck = false
var stuck_body
var type
onready var grid = get_parent()

func _ready():
	type = grid.ENTITY_TYPES.BLOCK

func _physics_process(delta):

	var target_position = grid.request_move(self, direction)
	if target_position:
		grid.get_node("Player").move_to(target_position)
		$Tween.start()
