class_name IdleState
extends NodeState

@export var player: Player

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var input_direction: Vector2 = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	
	player.sprite.play("IDLE" + "_" + player.face_direction)
	#player.sprite.flip_h = input_direction.x < 0
	
	player.velocity = input_direction * player.speed

func _on_next_transitions() -> void:
	if player.velocity != Vector2.ZERO:
		transition.emit("WalkState")
		
	if player.current_tool == Globals.Tools.AXE && Input.is_action_just_pressed("LCLICK"):
		transition.emit("ChopState")
		
	if player.current_tool == Globals.Tools.PICKAXE && Input.is_action_just_pressed("LCLICK"):
		transition.emit("MineState")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	player.sprite.stop()
