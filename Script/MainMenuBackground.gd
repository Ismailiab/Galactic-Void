extends ParallaxBackground

# Speeds for each layer. Layer 1 will be static, others will have increasing speeds.
var layer_speeds = [0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2]


func _process(delta):
	#Layer1 is excluded
	for i in range(2, 7):
		var parallax_layer = get_node("ParallaxLayer" + str(i + 1))
		# Update the motion offset based on the speed and the frame's delta time
		# This will only affect layers 2-7, layer 1 will remain static
		parallax_layer.motion_offset.x += layer_speeds[i] * delta




