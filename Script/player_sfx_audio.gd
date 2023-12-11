extends Node

var jump = preload("res://Sound/Sound Effects/jump.wav")
var double_jump = preload("res://Sound/Sound Effects/DoubleJump.wav")
var player_attack = preload("res://Sound/Sound Effects/whoosh.wav")
var player_damage = preload("res://Sound/Sound Effects/player_damage.wav")

var bot_wheel_attack = preload("res://Sound/Sound Effects/DroneZapperAttack.wav")
var bot_wheel_damage = preload("res://Sound/Sound Effects/BotWheelDamage.wav")


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

#Determine sound effect to be played
func play_player_sfx(sfx_name: String):
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
	
	
	#Add the ASP node to the scene and play it
	add_child(asp)
	asp.bus = "sfx"
	asp.play()
	
	#Deletes asp once the sound is done playing
	await asp.finished
	asp.queue_free()
	

#Determine sound effect to be played
func play_enemy_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "damage":
		stream = bot_wheel_damage
	elif sfx_name == "bot_wheel_attack":
		stream = bot_wheel_attack
	else:
		print("Invalid sound effect name")
	
	#New ASP node to play sound when funciton called
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	
	
	#Add the ASP node to the scene and play it
	add_child(asp)
	asp.bus = "sfx"
	asp.play()
	
	#Deletes asp once the sound is done playing
	await asp.finished
	asp.queue_free()
	



