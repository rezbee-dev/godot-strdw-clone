class_name WalkState
extends NodeState

@export var player: Player

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var input_direction = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	player.velocity = input_direction * player.speed
	
	if input_direction.length() > 0: # check if player is moving
		if abs(input_direction.x) > abs(input_direction.y): # check horizontal or vertical mvment
			player.face_direction = "SIDE"
			player.sprite.flip_h = input_direction.x < 0
		else:
			player.face_direction = "BACK" if input_direction.y < 0 else "FRONT"
			
	player.sprite.play("WALK" + "_" + player.face_direction)
	player.move_and_slide()


func _on_next_transitions() -> void:
	if player.velocity == Vector2.ZERO:
		transition.emit("IdleState")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	player.sprite.stop()
