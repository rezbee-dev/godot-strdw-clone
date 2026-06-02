extends Node2D

@export var environment: TileMapLayer
var tile_info: Dictionary[Vector2i, FarmManager.FarmTile]
@onready var player: CharacterBody2D = $Player
@onready var tilledTileMapLayer: TileMapLayer = $"Ground/Tilled Soil"
@onready var groundTileMapLayer: TileMapLayer = $"Ground"
@onready var highlight_tilemaplayer: TileMapLayer = $"Ground/Highlight"
var tiles = []

var highlighted_tile = {
	"local_coords": null,
	"atlas_coords": null,
	"last_hovered_cell": null,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highlighted_tile.local_coords = groundTileMapLayer.local_to_map(player.global_position)
	highlighted_tile.atlas_coords = groundTileMapLayer.get_cell_atlas_coords(highlighted_tile.local_coords)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_highlight_tile_on_hover()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LCLICK"):
		var mouse_pos = highlight_tilemaplayer.local_to_map(get_global_mouse_position())
		var player_pos = highlight_tilemaplayer.local_to_map(player.global_position)
		
		print("Mouse position: " + str(mouse_pos))
		print("Player position: " + str(player_pos))
		
		var cell: TileData = groundTileMapLayer.get_cell_tile_data(mouse_pos)
		#cell.modulate = Color(152.222, 100.011, 172.673, 0.8)
		#groundTileMapLayer.set_cell(mouse_pos, 0, Vector2i(9,2), 1)
		tiles.append(mouse_pos)
		tilledTileMapLayer.set_cells_terrain_connect(tiles,0, 0)
		
		
func _highlight_tile_on_hover():
	var mouse_pos = groundTileMapLayer.local_to_map(get_global_mouse_position())
	
	#if highlighted_tile.local_coords == null:
		#highlighted_tile.local_coords = mouse_pos
		#highlighted_tile.atlas_coods = groundTileMapLayer.get_cell_atlas_coords(mouse_pos)
		#groundTileMapLayer.set_cell(mouse_pos, 0, Vector2i(9,2), 1)
		#print("highlighted on start!")
		#return
		
	if highlighted_tile.local_coords != mouse_pos:
		
		if highlighted_tile.last_hovered_cell != null:
			highlight_tilemaplayer.erase_cell(highlighted_tile.last_hovered_cell)
			#highlight_tilemaplayer.set_cell(mouse_pos, -1, Vector2i(-1, -1), -1)
			
		#highlight_tilemaplayer.set_cell(highlighted_tile.local_coords, 0, highlighted_tile.atlas_coords)
		
		highlighted_tile.local_coords = mouse_pos
		highlighted_tile.atlas_coods = highlight_tilemaplayer.get_cell_atlas_coords(mouse_pos)
		highlighted_tile.last_hovered_cell = mouse_pos
		
		highlight_tilemaplayer.set_cell(mouse_pos, 0, Vector2i(9,10), 1)
		#highlight_tilemaplayer.set_cell(mouse_pos, 0, Vector2i(21,2))
		
		

	
