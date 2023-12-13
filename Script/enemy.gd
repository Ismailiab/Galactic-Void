extends CharacterBody2D

@export var speed = 120
@export var health = 50

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_tree().get_nodes_in_group("Player")
@onready var attack_cooldown_timer = $AttackCooldown 

var can_attack : bool = true


#State machine logic to handle enemy transitions between actions
enum State {IDLE, CHASING, ATTACKING, DEATH, DAMAGE}
var current_state = State.IDLE
#Defined in enemy specific scripts
var attack_range = 0

func _physics_process(delta):
	if current_state != State.DEATH:
		match current_state:
			State.IDLE:
				# Idle state physics processing, if any
				pass
			State.CHASING:
				if is_player_in_attack_range():
					change_state(State.ATTACKING)
				else:
					chase_player(delta)
			State.ATTACKING:
				# Attacking state physics processing, if any
				attack_player()
			State.DAMAGE:
				# Damage state physics processing, if any
				await animated_sprite.animation_finished
				change_state(State.CHASING)
			State.DEATH:
				#Handled in change_state()
				pass
	
	perform_physics_process(delta)

func perform_physics_process(_delta):
	pass


func change_state(new_state):
	#prevent change if in death
	if new_state == State.DEATH:
		pass
		
	#Change to the new state
	current_state = new_state
	#Setup logic for the new state
	match current_state:
		State.IDLE:
			animated_sprite.play("idle")
		State.CHASING:
			pass
		State.ATTACKING:
			pass
		State.DAMAGE:
			animated_sprite.play("take_damage")
		State.DEATH:
			animated_sprite.play("death")
			handle_death()

func chase_player(delta):
	var target_position = get_target_position()
	var step = (speed * delta)
	var new_position = position.move_toward(target_position, step)
	animated_sprite.play("move")
	#velocity.y = 0
	velocity.x = (new_position.x - position.x) / delta
	if new_position.x > position.x:
		animated_sprite.flip_h = false
	elif new_position.x < position.x:
		animated_sprite.flip_h = true
	move_and_slide()

#Player within wake range
func _on_detection_area_body_entered(body):
	if health > 0 || current_state != State.DEATH:
		animated_sprite.play("wake")
		player = body
		change_state(State.CHASING)

#Player left range
func _on_detection_area_body_exited(body):
	if health > 0 || current_state != State.DEATH:
		if body == player:
			change_state(State.IDLE)

func get_target_position():
	return player.position

func get_current_position():
	return position

func is_player_in_attack_range():
	if player && player.global_position:
		return player.global_position.distance_to(global_position) < attack_range
	return false 

func _on_attack_cooldown_timeout():
	if health < 0 || current_state == State.DEATH:
		return
	else:
		can_attack = true

func take_damage(damage):
	if current_state != State.DEATH:
		AudioPlayer.play_enemy_sfx("enemy_damage")
		health -= damage
		
		if health <= 0:
			change_state(State.DEATH)
		else:
			change_state(State.DAMAGE)


func handle_death():
	set_physics_process(false)
	current_state = State.DEATH
	attack_cooldown_timer.stop()
	attack_cooldown_timer.queue_free()
	can_attack = false
	$DetectionArea.queue_free()
	$CollisionShape2D.queue_free()
	await get_tree().create_timer(3.0).timeout
	queue_free()

func pause_death_animation():
	animated_sprite.pause()
	await get_tree().create_timer(5.0).timeout

#Defined in enemy specific scripts
func attack_player():
	pass
