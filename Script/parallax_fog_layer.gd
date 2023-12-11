extends ParallaxBackground

@onready var parallax_fog_layer = $ParallaxFogLayer

func _process(delta):
	#Fog layer scrolling effect
	parallax_fog_layer.motion_offset.x -= 15 * delta
	parallax_fog_layer.position.y = 209
	if parallax_fog_layer.position.x >= -1:
		parallax_fog_layer.position.x = -576
