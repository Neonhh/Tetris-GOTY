extends TileMap

# Declare member variables here. Examples:
var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(25,21)
var grid = []

enum ENTITY_TYPES{PLAYER,FBLOCK,LBLOCK}

onready var Tetromino = preload("res://Scenes/Blocks/TetrisBlock1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#Grid setup
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func cell_is_vacant(checker):
	
	var pos = checker.position
	var direction = checker.current_direction
	var grid_pos = world_to_map(pos) + direction
	
	if (grid_pos.x < grid_size.x) and (grid_pos.x >= 0):
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null or grid[grid_pos.x][grid_pos.y] == checker.type  else false
	return false

func update_child_pos(child:Node2D):
	
	var grid_pos = world_to_map(child.position)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_pos = grid_pos + world_to_map(child.direction)
	grid[new_pos.x][new_pos.y] = child.type
	
	var new_grid_pos = map_to_world(new_pos)
	return new_grid_pos