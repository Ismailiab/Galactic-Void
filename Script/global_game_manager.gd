extends Node


@onready var game_world = $GameGroup/GameWorld
@onready var save_game = $GameGroup/SaveGame

func _ready():
	GlobalScript._get_node_reference(get_path(), "GameManager")
