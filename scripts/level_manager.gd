extends Node2D

@export var player: CharacterBody2D
@export var ground_node: TileMapLayer 
@export var highlight_node: TileMapLayer 

var highlighted_tile: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highlighted_tile = ground_node.local_to_map(player.global_position) # setting to not get NPE 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_highlight_tile_on_hover()


func _highlight_tile_on_hover():
	var mouse_pos: Vector2i = ground_node.local_to_map(get_global_mouse_position())
		
	if highlighted_tile != mouse_pos:
		# remove previous highlighted tile
		highlight_node.erase_cell(highlighted_tile)
		# store new highlighted tile position
		highlighted_tile = mouse_pos
		# activate new highlighted tile by setting it to the alternative tile 
		highlight_node.set_cell(mouse_pos, 0, Vector2i(9,10), 1)
