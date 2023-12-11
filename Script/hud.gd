extends Control

@onready var lives_left = $HBoxContainer/LivesLeft
@onready var player_health = $PlayerHealth
@onready var player = get_tree().get_nodes_in_group("Player")[0]

var health = 100:
	get:
		return health
	set(value):
		health = value
		player_health.value = value

var lives = 5:
	get:
		return lives
	set(value):
		lives = value
		if value > 0:
			lives_left.text = "x" + str(value)
			health = 100
			

func _ready():
	#set player health on load
	player_health.value = 100


#Reduce player health on damage
func _on_player_took_damage(damage):
	health -= damage
	#Check if health is 0
	if health <= 0:
		health = 0


func get_lives():
	return lives

func get_health():
	return health
