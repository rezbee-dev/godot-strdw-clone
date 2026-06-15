extends StaticBody2D 

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_component.on_hurt.connect(_on_hurt)
	damage_component.max_damage_reached.connect(_on_max_damage_reached)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hurt(damage:int) -> void:
	damage_component.apply_damage(damage)
	
func _on_max_damage_reached() -> void:
	#queue_free()
	await get_tree().create_timer(1).timeout
	queue_free()
	
