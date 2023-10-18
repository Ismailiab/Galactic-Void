extends Node


var animated_sprite : AnimatedSprite2D
var direction : Vector2 = Vector2.ZERO
var animation_locked : bool = false

func initialize(sprite_ref : AnimatedSprite2D):
	animated_sprite = sprite_ref


#Update player animation
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("Run")
		else:
			animated_sprite.play("Idle")

#Flip sprite to face direction it is moving
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

# Update the direction for animations
func set_direction(dir):
	direction = dir
	update_facing_direction()

#Jump animations
func jump_start_animation():
	animated_sprite.play("Jump_start")
	animation_locked = true

func jump_end_animation():
	animated_sprite.play("Jump_end")
	animation_locked = true

func double_jump_animation():
	animated_sprite.play("Double_jump")
	animation_locked = true

func land_animation():
	animated_sprite.play("Double_jump_land")
	animation_locked = true

func attack_1_animation():
	animated_sprite.play("Attack1")
	animation_locked = true

#Listen for node signal to stop lock on landing animation
func _on_animated_sprite_2d_animation_finished():
	#Using an array to check for multiple animations
	if (["Jump_start", "Jump_end", "Double_jump", "Double_jump_land", "Attack1"]).has(animated_sprite.animation):
		animation_locked = false
	if get_parent().is_attacking == true:
		get_parent().is_attacking = false
	
	print(get_parent().is_attacking)
