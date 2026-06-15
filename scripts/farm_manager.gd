# Responsible for managing farm scene soil stuff (tilling, farming, watering, etc)
# To check if soil is tilled, we just check if "Tilled Soil" tilemaplayer tile exists via source ID
#   - sourceID of 0 means exists; sourceID of -1 means does not exist

extends Node2D

@export var player: CharacterBody2D
@export var tilled_node: TileMapLayer # For tilling soil
@export var ground_node: TileMapLayer # Root TileMapLayer where grass is located

var tiles = [] # see _till_soil()
enum Terrain {SUNNY_GRASS, SAND}

func _ready() -> void:
	print(str(player.global_position))

func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LCLICK"):
		var mouse_pos = ground_node.local_to_map(get_global_mouse_position())
		var player_pos = ground_node.local_to_map(player.global_position)
		#_till_soil(mouse_pos)

func _till_soil(pos: Vector2i) -> void:
	if not _is_ground(pos):
		return
	
	var cell: TileData = ground_node.get_cell_tile_data(pos)
	
	# check if tile is grass or sand
	if cell.terrain != Terrain.SUNNY_GRASS:
		return
	
	# In order to use terrain, need to store local coords of other terrain tiles
	tiles.append(pos)
	tilled_node.set_cells_terrain_connect(tiles,0, 0)

# sourceID of 0 means exists; sourceID of -1 means does not exist
func _is_tilled(pos: Vector2i) -> bool:
	return tilled_node.get_cell_source_id(pos) == 0
	
func _is_ground(pos: Vector2i) -> bool:
	return ground_node.get_cell_source_id(pos) == 0
