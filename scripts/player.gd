# src: https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html

extends CharacterBody2D

@export var speed = 300.0
@onready var sprite = $AnimatedSprite2D

var face_direction := "FRONT"
var anim := "IDLE_FRONT"

func get_input():
	
	var input_direction = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	velocity = input_direction * speed
	
	# Set face_direction
	if input_direction.length() > 0: # check if player is moving
		if abs(input_direction.x) > abs(input_direction.y): # check horizontal or vertical mvment
			face_direction = "SIDE"
			sprite.flip_h = input_direction.x < 0
		else:
			face_direction = "BACK" if input_direction.y < 0 else "FRONT"
			
	anim = ("WALK" if velocity.length() > 0.0 else "IDLE") + "_" + face_direction
	sprite.play(anim)
	
	
func _ready():
	sprite.stop()
	sprite.play("IDLE_FRONT")
	
	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide() # moves based on velocity
