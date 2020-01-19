extends Node2D

enum ENTITY_TYPES{EMPTY = -1, PLAYER, BLOCK, WALL} #Posibles marcas para cada celda
export(ENTITY_TYPES) var type = ENTITY_TYPES.PLAYER