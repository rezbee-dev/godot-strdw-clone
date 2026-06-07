# Responsible for managing farm scene soil stuff (tilling, farming, watering, etc)
# To check if soil is tilled, we just check if "Tilled Soil" tilemaplayer tile exists via source ID
#   - sourceID of 0 means exists; sourceID of -1 means does not exist

extends Node2D

@export var environment: TileMapLayer

@onready var player: CharacterBody2D = $Player
@onready var tilled_node: TileMapLayer = $"Container/Tilled Soil" # For tilling soil
@onready var ground_node: TileMapLayer = $"Container/Ground" # Root TileMapLayer where grass is located
@onready var highlight_node: TileMapLayer = $"Container/Highlight" # For Mouse hovering highlight

var tiles = [] # see _till_soil()
enum Terrain {SUNNY_GRASS, SAND}
var highlighted_tile: Vector2i

func _ready() -> void:
	print(str(player.global_position))
	highlighted_tile = ground_node.local_to_map(player.global_position) # setting to not get NPE 

func _process(delta: float) -> void:
	_highlight_tile_on_hover()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LCLICK"):
		var mouse_pos = highlight_node.local_to_map(get_global_mouse_position())
		var player_pos = highlight_node.local_to_map(player.global_position)
		_till_soil(mouse_pos)
		
		#print("Mouse position: " + str(mouse_pos))
		#print("Player position: " + str(player_pos))
		#print("Get source id: " + str(ground_node.get_cell_source_id(mouse_pos)))
		
		#var cell: TileData = ground_node.get_cell_tile_data(mouse_pos)
		#print("Terrain: " + str(cell.terrain))
		#tiles.append(mouse_pos)
		#tilled_node.set_cells_terrain_connect(tiles,0, 0)
		
		
func _highlight_tile_on_hover():
	var mouse_pos: Vector2i = ground_node.local_to_map(get_global_mouse_position())
		
	if highlighted_tile != mouse_pos:
		# remove previous highlighted tile
		highlight_node.erase_cell(highlighted_tile)
		# store new highlighted tile position
		highlighted_tile = mouse_pos
		# activate new highlighted tile by setting it to the alternative tile 
		highlight_node.set_cell(mouse_pos, 0, Vector2i(9,10), 1)

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

func _is_tilled(pos: Vector2i) -> bool:
	return tilled_node.get_cell_source_id(pos) == 0
	
func _is_ground(pos: Vector2i) -> bool:
	return ground_node.get_cell_source_id(pos) == 0
