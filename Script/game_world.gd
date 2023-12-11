extends Node

@export var save_game_path : NodePath

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var start_scene = $Level1/Start
@onready var pause_menu = $GamePause/PauseMenu
@onready var saved_popup = $GamePause/GameSavedPopup
@onready var enemies = $Enemies

var save_game = null

func _ready():
	saved_popup.hide()
	player.connect("player_died", reset_player)
	GlobalScript._get_node_reference(get_path(), "GameWorld")
	
	save_game = get_node(save_game_path)


func _on_save_game_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	save_game.save_data(GlobalScript.SAVE_DIR + GlobalScript.SAVE_FILE_NAME)


func _on_load_game_button_pressed():
	pass


func _on_death_zone_body_entered(body):
	if body == player:
		player = body
		player.hud.lives -= 1
		reset_player()

func reset_player():
	player.active = true
	if player.get_player_lives() == 0:
		pass
		#game_over()
	else:
		start_scene.animated_sprite.play("load_in")
		player.global_position = start_scene.get_spawn_position()
		await start_scene.animated_sprite.animation_finished
		start_scene.animated_sprite.play("idle")
		

#Temporarily hide the settings menu to show popup
func _on_pop_up_game_saved():
	pause_menu.hide()
	saved_popup.show()

func pop_up_game_saved_okay():
	saved_popup.hide()
	pause_menu.show()
