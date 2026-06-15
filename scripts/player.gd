# src: https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html
class_name Player
extends CharacterBody2D

@export var current_tool: Globals.Tools = Globals.Tools.NONE
@export var speed: float = 300.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var face_direction := "FRONT"
