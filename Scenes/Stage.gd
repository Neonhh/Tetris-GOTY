extends TileMap

enum ENTITY_TYPES{EMPTY = -1, PLAYER, BLOCK, LANDED_BLOCK, WALL} #posibles objetos que se mueven

func _ready():
	
	for child in get_children(): #Marca las que están ocupadas
		if child.get("hitbox_matrix"):
			process_hitbox_matrix(child.hitbox_matrix,child.position,child.type) #marca todas las celdas ocupadas por un cuerpo, dado por su hitbox_matrix

func get_cell_pawn(cell, type = ENTITY_TYPES.PLAYER):
	for node in get_children(): #Toma una celda y su marca
		if node.type != type:   #Devuelve el nodo que está en la celda.
			continue
		if world_to_map(node.position) == cell:
			return node
	return get_node("Player")

func request_move(pawn,direction):
	
	var colliders = get_collision_index(pawn,direction) # Devuelve un array que contiene las celdas en los extremos del cuerpo (esas son las que chequearan si hay colisión)

	for i in colliders.size():
		if colliders[i] == -1: #No colisiona
			continue
		
		var cell_start = world_to_map(pawn.position) + colliders[i]*direction #Desde esta celda se evaluan las colisiones
		var cell_target = cell_start + direction
		var target_tile_id = get_cellv(cell_target)
		
		match target_tile_id:
			ENTITY_TYPES.EMPTY:    #Marca la celda objetivo como ocupada, y la celda inicial como vacía.
				
				cell_start = world_to_map(pawn.position) #Reset a las variables, para que vuelvan a la posición "0" (sin sumar la celda de colisión)
				cell_target = cell_start + direction
				
				process_hitbox_matrix(pawn.hitbox_matrix,cell_start,ENTITY_TYPES.EMPTY) #Cambia el tipo de VARIAS celdas segun la matriz dada.
				#set_cellv(cell_start, ENTITY_TYPES.EMPTY)
				process_hitbox_matrix(pawn.hitbox_matrix,cell_target,pawn.type)
				#set_cellv(cell_target, pawn.type)
				
				return map_to_world(cell_target)
			
			ENTITY_TYPES.BLOCK, ENTITY_TYPES.PLAYER, ENTITY_TYPES.WALL: #No es posible el movimiento
				
				var pawn_name = get_cell_pawn(cell_target,target_tile_id).name
				
				print("La celda %s tiene a %s en ella"%[cell_target,pawn_name])
			
			ENTITY_TYPES.LANDED_BLOCK:
				print(pawn.name)
				match pawn.type:
					ENTITY_TYPES.LANDED_BLOCK:
						
						set_cellv(cell_start, ENTITY_TYPES.EMPTY)  #aqui tambien seria con process_hitbox_matrix, pero es que aun no funciona bien :c
						set_cellv(cell_target, ENTITY_TYPES.LANDED_BLOCK)
						
						return map_to_world(cell_target)
					ENTITY_TYPES.BLOCK, ENTITY_TYPES.PLAYER, ENTITY_TYPES.WALL:
						var pawn_name = get_cell_pawn(cell_target,target_tile_id).name
				
						print("LLa celda %s tiene a %s en ella"%[cell_target,pawn_name])
				
func process_hitbox_matrix(hmatrix,location,type):
	var matrix = hmatrix   #marca todas las celdas que ocupa el objeto, segun una matriz daa.
	var y = -1
	
	for i in range(matrix.size()): #Una matriz en un array de arrays
		var row = matrix[i] #Accede al primer array almacenado
		var x = -1    #"x" y "y" son contadores
		y += 1
		for j in range(row.size()): #accede a los componentes del array interior
			x += 1
			var component = row[j]
			if component == 1:     #Hay que marcar esta celda.
				print("marking cell" + str((world_to_map(location) + Vector2(x,y))) + "as" + str(type))
				set_cellv((world_to_map(location) + Vector2(x,y)),type)

func get_collision_index(node,direction):
	var matrix = node.hitbox_matrix #Matriz de colisión
	var collider #Array con las partes del cuerpo que pueden colisionar
	
	match direction:
		Vector2(1,0):    #Derecha
			var rightmost = []
			for i in range(matrix.size()):
				var row = matrix[i]
				rightmost.append([])
				rightmost[i] = row.rfind(1) #Indice del primer uno que encuentra, buscando de izquierda a derecha
			collider = rightmost
		
		Vector2(-1,0): #Izquierda
			var leftmost = []
			for i in range(matrix.size()):
				var row = matrix[i]
				leftmost.append([])
				leftmost[i] = row.find(1) #Indice del primer uno que encuentra, buscando de derecha a izquierda
			collider = leftmost
		
		Vector2(0,1): #Abajo
			for i in range(matrix.size()):
				var row = matrix[i]
				if row.find(1) == -1:
					continue
				var x = -1
				for j in range(row.size()):
					var component = row[j]
					if component == 1: #Almacena las posibles colisiones en la fila que está mas abao en el cuerpo
						x += 1
						var last_row = []
						last_row.append([])
						last_row[x] = j 
						collider = last_row
	return collider
