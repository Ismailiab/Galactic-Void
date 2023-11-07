extends Node

var jump = preload("res://Sound/Sound Effects/jump.wav")
var double_jump = preload("res://Sound/Sound Effects/DoubleJump.wav")
var player_attack = preload("res://Sound/Sound Effects/whoosh.wav")
var player_damage = preload("res://Sound/Sound Effects/player_damage.wav")

#Determine sound effect to be played
func play_sfx(sfx_name: String, volume_db: float = 0):
	var stream = null
	if sfx_name == "jump":
		stream = jump
	elif sfx_name == "double_jump":
		stream = double_jump
	elif sfx_name == "player_attack":
		stream = player_attack
	else:
		print("Invalid sound effect name")
	
	#New ASP node to play sound when funciton called
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.volume_db = volume_db
	
	#Add the ASP node to the scene and play it
	add_child(asp)
	asp.play()
	
	#Deletes asp once the sound is done playing
	await asp.finished
	asp.queue_free()
	




