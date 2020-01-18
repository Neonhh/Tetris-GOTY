extends TileMap

# Declare member variables here. Examples:
enum ENTITY_TYPES{EMPTY = -1,PLAYER,BLOCK,WALL}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		pass
		set_cellv(world_to_map(child.position),child.type)

func get_cell_pawn(cell, type = ENTITY_TYPES.PLAYER):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return node
		return $Player


func request_move(pawn,direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	print("a")
	var target_tile_id = get_cellv(cell_target)
	
	match target_tile_id:
		ENTITY_TYPES.EMPTY:
			set_cellv(cell_start, ENTITY_TYPES.EMPTY)
			set_cellv(cell_target, pawn.type)
			print("Yeehaw!")
			return map_to_world(cell_target)
		
		ENTITY_TYPES.BLOCK, ENTITY_TYPES.PLAYER, ENTITY_TYPES.WALL:
			var pawn_name = get_cell_pawn(cell_target,target_tile_id).name
			print("Cell %s is occupied by %s"%[cell_target,pawn_name])
	