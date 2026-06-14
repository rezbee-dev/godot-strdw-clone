class_name Utils
extends Node

func get_all_tile_layers_at_pos(position: Vector2, nodes: Array[Node]) -> Array[TileMapLayer]:
	var layers: Array[TileMapLayer] = []
	
	for node in nodes:
		if node is TileMapLayer:
			var map_position: Vector2i = node.local_to_map(position)
			
			# source_id -1 means tile is empty
			if node.get_cell_source_id(map_position) != -1:
				layers.append(node)
	
	return layers
