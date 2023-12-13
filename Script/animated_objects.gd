extends Node2D

@onready var animated_objects = get_tree().get_nodes_in_group("AnimatedObjects")

func _ready():
	for animated_object in animated_objects:
		animated_object.play("idle")
