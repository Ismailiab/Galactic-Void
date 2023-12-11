extends Node

#Create a reference to a type of node
var animated_sprite : AnimatedSprite2D
var direction : Vector2 = Vector2.ZERO
var animation_locked : bool = false

func initialize(sprite_ref : AnimatedSprite2D):
	animated_sprite = sprite_ref


#Update player animation when moving along the x axis
func update_animation():
	if ! animation_locked:
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
	#Attack animation takes priority to ensure players can attack
	#from all positions in the game
	if (animated_sprite.animation != "Attack1"):
		#Call on autoload audio player for sound
		AudioPlayer.play_player_sfx("jump")
		animated_sprite.play("Jump_start")
		animation_locked = true

func jump_end_animation():
	if (animated_sprite.animation != "Attack1"):
		animated_sprite.play("Jump_end")
		animation_locked = true

func double_jump_animation():
	if (animated_sprite.animation != "Attack1"):
		#Call on autoload audio player for sound
		AudioPlayer.play_player_sfx("double_jump")
		animated_sprite.play("Double_jump")
		animation_locked = true

func land_animation():
	if (animated_sprite.animation != "Attack1"):
		animated_sprite.play("Double_jump_land")
		animation_locked = true

#attack animation
func attack_1_animation():
	animated_sprite.play("Attack1")
	AudioPlayer.play_player_sfx("player_attack")
	animation_locked = true

#Damage animation
func take_damage_animation():
	animation_locked = true
	animated_sprite.play("Take_damage")
	AudioPlayer.play_player_sfx("player_damage")

#Death animation
func death_animation():
	animation_locked = true
	animated_sprite.play("Death")
	

#Listen for node signal to stop lock on landing animation
func _on_animated_sprite_2d_animation_finished():
	#Using an array to check for multiple animations and reset animation_locked var
	if (["Jump_start", "Jump_end", "Double_jump", "Double_jump_land", "Attack1", "Take_damage", "Death"]).has(animated_sprite.animation):
		animation_locked = false
	#Check the is_attacking var on player.gd and reset when required
	if get_parent().is_attacking == true:
		get_parent().is_attacking = false
		get_parent().hitbox.disabled = true
