extends Node

@onready var game_world = $GameWorld
@onready var save_game = $SaveGame

func _ready():
	GlobalScript._get_node_reference(get_path(), "GameGroup")
	


