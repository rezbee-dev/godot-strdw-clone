# Gets the damage/ hurt
class_name HurtComponent
extends Area2D

signal on_hurt

func _on_area_entered(area: Area2D) -> void:
	if area is HitComponent:
		print("hit!")
		on_hurt.emit(area.hit_damage)
