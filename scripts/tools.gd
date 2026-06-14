class_name Tool
extends Node

# TILLING TOOL #
static func till_soil(map_position: Vector2i, tiles: Array[TileMapLayer], tilled_tiles: Array[Vector2i], tilled_node: TileMapLayer) -> void:
	if not _is_ground(map_position, tiles): return
	
	# modifies tilled soil tilemaplayer node from scene (gdscript is pass by reference)
	_add_tilled_tile_to_terrain(map_position, tilled_tiles, tilled_node)

static func _add_tilled_tile_to_terrain(map_position: Vector2i, tilled_tiles: Array[Vector2i], tilled_layer: TileMapLayer) -> void:
	tilled_tiles.append(map_position)
	tilled_layer.set_cells_terrain_connect(tilled_tiles, 0,0) # 0,0 refers to terrain set 0 and terrain 0 in editor
	
# Since we have multiple tilemaplayer nodes on top of each other, need to iterate through each tile to determine if valid for tilling
static func _is_ground(map_position: Vector2i, tiles: Array[TileMapLayer]) -> bool:
	if tiles.size() == 0:
		return false
	
	for tile in tiles:
		var cell_data: TileData = tile.get_cell_tile_data(map_position)
		if cell_data && cell_data.has_custom_data("Tillable"):
			if cell_data.get_custom_data("Tillable"):
				return true
	
	return false
