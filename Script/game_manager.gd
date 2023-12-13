extends Node

@onready var game_world = $GameWorld
@onready var save_game = $SaveGame
@onready var animated_objects = get_tree().get_nodes_in_group("AnimatedObjects")

func _ready():
	GlobalScript._get_node_reference(get_path(), "GameGroup")
	



