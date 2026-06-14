extends Node

enum FarmTile {
	GRASS,
	TILLED,
	TILLED_WATERED
}

class FarmGroundState:
	var tilled: bool
	var watered: bool
	
var farm_tile_coords: Dictionary[FarmTile, Vector2i] = {
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
