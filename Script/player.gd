extends CharacterBody2D

signal took_damage
signal player_died

#Changing to @export var allows for editing within inspector table
@export var speed : float = 250.0
@export var jump_velocity : float = -400.0
@export var double_jump_velocity : float = -300.0


@onready var animation_handler = $player_animation_handler
@onready var hitbox = $AnimatedSprite2D/HitBox/CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer  = $CoyoteTimer
@onready var hud = $CanvasLayer/HUD


#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var is_attacking : bool = false
var is_on_ground : bool = true


#Ensure this function remains in player.gd
func _ready():
	animation_handler.initialize(animated_sprite)
	
	GlobalScript._get_node_reference(get_path(), "Player")

func _physics_process(delta):
	is_on_ground = is_on_floor()
	#Add the gravity.
	if is_on_ground == false:
		velocity.y += gravity * delta
		#Cap gravity
		if velocity.y > 500:
			velocity.y = 500
		was_in_air = true
	else:
		#Stop timer if player is on the ground
		coyote_timer.stop()
		
		has_double_jumped = false
		
		if was_in_air:
			land()
		was_in_air = false
	
	#Handle attack
	if Input.is_action_just_pressed("Attack1") && ! is_attacking:
		attack_1()
	
	#Handle Jumps
	if Input.is_action_just_pressed("jump"):
		#Check for coyote timer
		if is_on_ground || coyote_timer.time_left > 0:
			#Normal jump from ground
			jump()
		elif ! has_double_jumped:
			#Double jump in air
			double_jump()
	
	#Call animation handler for falling animation
	if velocity.y > 0 && !is_on_ground:
		animation_handler.jump_end_animation()
	
	#Get the input direction from mapped inputs
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Variable for coyote timer purposes
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	#Start coyote timer to allow a player to jump shortly
	#after leaving the ground
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	
	#Update direction and animation based on player input
	animation_handler.set_direction(direction)
	
	#Flip Area2D hitbox with direction
	if direction.x < 0:
		$AnimatedSprite2D/HitBox.scale.x = direction.x
	elif direction.x > 0:
		$AnimatedSprite2D/HitBox.scale.x = direction.x
	
	animation_handler.update_animation()

#Return is_on_floor()
func get_is_on_ground():
	return is_on_ground

#Jump and play animation for jump from the animation handler
func jump():
	velocity.y = jump_velocity
	animation_handler.jump_start_animation()
	

#Function to double jump and play animation from the animation handler
func double_jump():
	velocity.y = double_jump_velocity
	animation_handler.double_jump_animation()
	has_double_jumped = true

#Play landing animaiton from the animation handler
func land():
	animation_handler.land_animation()

#Play Attack1 animation from the animation handler
func attack_1():
	is_attacking = true
	hitbox.disabled = false
	animation_handler.attack_1_animation()

#Take damage from enemy
func player_take_damage(damage):
	if hud.health > 0:
		emit_signal("took_damage", damage)
		animation_handler.take_damage_animation()
	elif hud.health <= 0:
		player_die()

func player_die():
	animation_handler.death_animation()
	await get_tree().create_timer(2.0).emit_signal("player_died")
	var lost_life = hud.lives - 1
	hud.lives = lost_life
	


func _on_hit_box_body_entered(body):
	if body.has_method("take_damage"):
		var damage = 15
		body.take_damage(damage)


func get_player_health():
	return hud.get_health()

func get_player_lives():
	return hud.get_lives()

