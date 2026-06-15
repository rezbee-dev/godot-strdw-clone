# src: https://github.com/rapidvectors/tutorial-components-and-scripts/blob/main/scripts/state_machine_v1/node_state.gd

class_name NodeState
extends Node

@warning_ignore("unused_signal")
signal transition 


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
