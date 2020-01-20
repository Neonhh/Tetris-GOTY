extends "res://Scenes/type.gd"

export (PackedScene) var Block1

onready var grid = get_parent()

var spawn_time = 5

var timer = 0

func _ready():
	randomize()

func _process(delta: float) -> void:
	timer += delta
	if timer >= spawn_time:
		$Spawner/PathFollow2D.set_offset(randi())
		#print($Spawner/PathFollow2D.position)
		var block1 = Block1.instance()
		get_parent().add_child(block1)
		block1.position = $Spawner/PathFollow2D.position
		timer = 0