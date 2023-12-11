extends "enemy.gd"

#signal animation_finished
#Load the enemy bot wheel scene only once
var bullet_scene = preload("res://Scene/enemy_bot_wheel_bullet.tscn")

@onready var bullet_container = $BulletContainer


func _ready():
	attack_range = 70
	health = 60

func attack_player():
	if can_attack == true:
		velocity.y = 0
		animated_sprite.play("charge")
		await animated_sprite.animation_finished
		shoot()
		change_state(State.CHASING)


#Create an instance of the bullet
func shoot():
	if !is_instance_valid(self):
		return
		
	if can_attack == true:
		can_attack = false
		var bullet_instance = bullet_scene.instantiate()
		#Add the bullet instance as a child to the bullet container
		bullet_container.add_child(bullet_instance)
		#Match the position of the enemy
		animated_sprite.play("attack")
		#Correct bullet position to come out of enemy gun
		var bullet_position = global_position
		bullet_position.y -= 3
		bullet_instance.global_position = bullet_position
		#Bullet travels toward player
		bullet_instance.direction = (player.global_position - global_position).normalized()
		AudioPlayer.play_enemy_sfx("bot_wheel_attack")
		
		if is_instance_valid(attack_cooldown_timer):
			attack_cooldown_timer.start()
		change_state(State.CHASING)


