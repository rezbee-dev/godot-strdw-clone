# Responsible for managing current scene soil

extends Node2D

@export var environment: TileMapLayer

@onready var player: CharacterBody2D = $Player
@onready var tilledTML: TileMapLayer = $"Ground/Tilled Soil" # For tilling soil
@onready var groundTML: TileMapLayer = $"Ground" # Root TileMapLayer where grass is located
@onready var highlightTML: TileMapLayer = $"Ground/Highlight" # For Mouse hovering highlight

var tile_info: Dictionary[Vector2i, FarmManager.FarmTile]
var tiles = []
var highlighted_tile = null

func _ready() -> void:
	highlighted_tile = groundTML.local_to_map(player.global_position) # setting to not get NPE 

func _process(delta: float) -> void:
	_highlight_tile_on_hover()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LCLICK"):
		var mouse_pos = highlightTML.local_to_map(get_global_mouse_position())
		var player_pos = highlightTML.local_to_map(player.global_position)
		
		print("Mouse position: " + str(mouse_pos))
		print("Player position: " + str(player_pos))
		
		var cell: TileData = groundTML.get_cell_tile_data(mouse_pos)
		tiles.append(mouse_pos)
		tilledTML.set_cells_terrain_connect(tiles,0, 0)
		
		
func _highlight_tile_on_hover():
	var mouse_pos = groundTML.local_to_map(get_global_mouse_position())
		
	if highlighted_tile != mouse_pos:
		# remove previous highlighted tile
		highlightTML.erase_cell(highlighted_tile)
		# store new highlighted tile position
		highlighted_tile = mouse_pos
		# activate new highlighted tile by setting it to the alternative tile 
		highlightTML.set_cell(mouse_pos, 0, Vector2i(9,10), 1)
