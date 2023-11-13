extends CharacterBody2D

@export var speed = 120

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var direction : Vector2 = Vector2.ZERO
var player_chase = false
var player = null


func _physics_process(delta):
	if player_chase && player != null:
		#Get the player position
		var target_position = player.position
		
		var current_position = position
		var step = speed * delta
		
		var new_position = current_position.move_toward(target_position, step)
		
		#Maintain Y position for enemy
		#if current_position.y > 226:
		#	current_position.y = 226
		
		
		animated_sprite.play("move")
		#Keep enemy moving along the x axis
		velocity.y = 0
		velocity.x = (new_position.x - position.x) / delta
		
		#Flip the sprites facing direction
		if new_position.x > current_position.x:
			animated_sprite.flip_h = false
		elif new_position.x < current_position.x:
			animated_sprite.flip_h = true
		
		move_and_slide()
		


#Player within wake range
func _on_detection_area_body_entered(body):
	animated_sprite.play("wake")
	player = body
	player_chase = true

#Player left range
func _on_detection_area_body_exited(body):
	animated_sprite.play("idle")
	player = null
	player_chase = false


