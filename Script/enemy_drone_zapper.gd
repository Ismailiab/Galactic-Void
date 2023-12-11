extends "enemy.gd"

@onready var enemy_hitbox = $AnimatedSprite2D/EnemyHitBox/CollisionShape2D

#Seconds between shots
var fixed_y_position: float = 27

func _ready():
	attack_range = 35
	speed = 175
	health = 45
	enemy_hitbox.disabled = true
	fixed_y_position = global_position.y - fixed_y_position

func perform_physics_process(_delta):
	global_position.y =  fixed_y_position


   

func attack_player():
	if can_attack == true:
		can_attack = false
		animated_sprite.play("attack")
		AudioPlayer.play_enemy_sfx("drone_zapper_attack")
		get_tree().create_timer(1.0).timeout.connect(enable_enemy_hitbox)
		get_tree().create_timer(0.01).timeout.connect(disable_enemy_hitbox)
		attack_cooldown_timer.start()
		if is_instance_valid(attack_cooldown_timer):
			attack_cooldown_timer.start()
		change_state(State.CHASING)

func enable_enemy_hitbox():
	enemy_hitbox.disabled = false

func disable_enemy_hitbox():
	enemy_hitbox.disabled = true


func _on_enemy_hit_box_body_entered(body):
	if body.has_method("player_take_damage"):		
		var damage = 8
		body.player_take_damage(damage)
