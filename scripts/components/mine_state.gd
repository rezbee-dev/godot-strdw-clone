class_name MineState
extends NodeState

@export var player: Player
@export var collision_shape: CollisionShape2D

func _ready() -> void:
	collision_shape.disabled = true
	collision_shape.position = Vector2.ZERO
	
func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	#if player.velocity == Vector2.ZERO:
	if !player.sprite.is_playing():
		transition.emit("IdleState")


func _on_enter() -> void:
	
	# player.sprite.play("IDLE" + "_" + player.face_direction)
	
	var input_direction: Vector2 = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	
	if player.face_direction == "SIDE":
		if player.sprite.flip_h:
			collision_shape.position = Vector2(-12, 4)
		else:
			print("not flipped")
			collision_shape.position = Vector2(12, 4)
	elif player.face_direction == "BACK":
		collision_shape.position = Vector2(0,-10)
	elif player.face_direction == "FRONT":
		collision_shape.position = Vector2(0,10)
				
			
	print("MINE"+"_"+player.face_direction)
	print("AFTER: " + str(collision_shape.position))
	#player.sprite.play("MINE" + "_" + player.face_direction)
	player.sprite.play("MINE" + "_" + player.face_direction)
	collision_shape.disabled = false


func _on_exit() -> void:
	player.sprite.stop()
	collision_shape.disabled = true
	collision_shape.position = Vector2.ZERO
