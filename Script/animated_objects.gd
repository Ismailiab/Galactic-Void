extends Node2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

#Animate sprite for background object
func _ready():
	animated_sprite.play("idle")
