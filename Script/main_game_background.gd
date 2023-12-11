extends ParallaxBackground


@onready var animated_sprites_set_one = get_tree().get_nodes_in_group("BackgroundLightning")
@onready var animated_sprites_set_two = get_tree().get_nodes_in_group("BackgroundLightning")
@onready var prev_bg = null
@onready var rand_bg_animated_sprite_one = null
@onready var rand_bg_animated_sprite_two = null
@onready var bg_timer : Timer = null
@onready var number = 0

var can_play_process : bool = true
var can_play_set_one : bool = true
var can_play_set_two : bool = true

#Animate sprite for background object
func _ready():
	randomize()

func _process(_delta):
	if can_play_process == true:
		play_first()
		play_second()

#Play first set of animated sprites
func play_first():
	if can_play_set_one == true:
		can_play_set_one = false
		play_random_background_lightning(animated_sprites_set_one)

#Play second set of animated sprites
func play_second():
	if can_play_set_two == true:
		can_play_set_two = false
		play_random_background_lightning(animated_sprites_set_two)


func play_random_background_lightning(animated_sprite_set):
	var random_bg = get_random_background_lightning(animated_sprite_set)
	random_bg.play("idle")
	get_random_time_timer()

#Play animated sprite
func get_random_time_timer():
	var time = get_random_integer()
	get_tree().create_timer(time).timeout.connect(_on_background_lightning_timer_timeout)

#Random integer used for setting timer
func get_random_integer():
	#Generate randmon integer between 0 and 3
	number = randi() % 10
	if number == 0:
		number = number + 1
	return number

#Reset boolean values to play animations
func _on_background_lightning_timer_timeout():
	can_play_process = true
	if can_play_set_one == false:
		can_play_set_one = true
	elif can_play_set_two == false:
		can_play_set_two = true

#Randomize animated sprite selection
func get_random_background_lightning(animated_sprites):
	var rand_bg = animated_sprites[randi() % animated_sprites.size()]
	while rand_bg == prev_bg:
		#Prevent the last animated sprite from being picked again
		rand_bg = animated_sprites[randi() % animated_sprites.size()]
		
	prev_bg = rand_bg.duplicate()
	
	return rand_bg
