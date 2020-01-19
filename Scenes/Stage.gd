extends TileMap

enum ENTITY_TYPES{EMPTY = -1,PLAYER,BLOCK,WALL}

func _ready():
	for child in get_children(): #Marca las que están ocupadas
		set_cellv(world_to_map(child.position),child.type)

func get_cell_pawn(cell, type = ENTITY_TYPES.PLAYER):
	for node in get_children(): #Toma una celda y su marca
		if node.type != type:   #Devuelve el nodo que está en la celda.
			continue
		if world_to_map(node.position) == cell:
			return node
	return get_node("Player")

func request_move(pawn,direction):
	var cell_start = world_to_map(pawn.position)  #Chequea si no hay cuerpos en la celda objetivo, entonces coloca las marcas correspondientes.
	var cell_target = cell_start + direction
	var target_tile_id = get_cellv(cell_target)
	
	match target_tile_id:
		ENTITY_TYPES.EMPTY:    #Marca la celda objetivo como ocupada, y la celda inicial como vacía.
			
			set_cellv(cell_start, ENTITY_TYPES.EMPTY)
			set_cellv(cell_target, pawn.type)
			
			return map_to_world(cell_target)
		
		ENTITY_TYPES.BLOCK, ENTITY_TYPES.PLAYER, ENTITY_TYPES.WALL: #No es posible el movimiento
			
			var pawn_name = get_cell_pawn(cell_target,target_tile_id).name
			
			print("La celda %s tiene a %s en ella"%[cell_target,pawn_name])