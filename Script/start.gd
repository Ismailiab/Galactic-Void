extends StaticBody2D

#Create reference to SpawnPosition Marker
@onready var spawn = $SpawnPosition

@onready var animated_sprite = $AnimatedSprite2D

#Return the spawn position for the start of the level
func get_spawn_position():
	return spawn.global_position

