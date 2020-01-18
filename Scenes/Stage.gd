extends TileMap

# Declare member variables here. Examples:
var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(25,21)
var grid = []

enum ENTITY_TYPES{PLAYER,FALLING_BLOCK,LANDED_BLOCK}

onready var Tetromino = preload("res://Scenes/Blocks/TetrisBlock1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#Grid setup
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func cell_is_vacant():
	pass

func update_chid_pos():
	pass