extends Node

var thunder_crack = preload("res://Sound/Sound Effects/ThunderCrack.wav")
var distant_thunder = preload("res://Sound/Sound Effects/DistantThunder.wav")
var distant_thunder_crack = preload("res://Sound/Sound Effects/DistantThunderCrack.wav")

var rand_num = RandomNumberGenerator.new()

var timer_time = null
var bg_sfx_name = null
var can_play : bool = true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()

func _process(_delta):
	if can_play == true:
		can_play = false
		timer_time = rand_num.randi_range(5, 10)
		get_tree().create_timer(timer_time).timeout.connect(get_random_bg_sound)
	
	

func get_random_bg_sound():
	var num = randi() % 4
	if num == 0:
		num = num + 1
	
	if num == 1:
		bg_sfx_name = "thunder_crack"
	elif num == 2:
		bg_sfx_name = "distant_thunder"
	elif num == 3:
		bg_sfx_name = "distant_thunder_crack"
	
	play_bg_sfx(bg_sfx_name)

#Determine sound effect to be played
func play_bg_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "thunder_crack":
		stream = thunder_crack
	elif sfx_name == "distant_thunder":
		stream = distant_thunder
	elif sfx_name == "distant_thunder_crack":
		stream = distant_thunder_crack
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
	
	bg_sfx_name = null
	can_play = true
