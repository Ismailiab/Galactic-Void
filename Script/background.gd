extends ParallaxBackground

#Allow for easy level adjustment within inspector pane
@export var bg_texture: CompressedTexture2D = preload("res://Art/Levels/Tilesets/The DARK Series - Camp & Paralalax Forest/Forest Parallax/bg.png")

#Variable to reference Sprite2D
@onready var sprite = $ParallaxLayer/Sprite2D

func _ready():
	sprite.texture = bg_texture
