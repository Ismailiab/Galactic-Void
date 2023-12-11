extends Node

signal toggle_game_paused(is_paused : bool)

#Save/Load Variables
const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
#const SECURITY_KEY = "208ASEGR" 

var player : NodePath
var game_world : NodePath
var main_menu : NodePath


var user_name : String = ""

#Game paused variable with getter/setter methods
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused

func _ready():
	#Set root node to always process regardless of tree state
	process_mode = Node.PROCESS_MODE_ALWAYS
	verify_save_directory(GlobalScript.SAVE_DIR)

#Pause game
func _input(event : InputEvent):
	if (event.is_action_pressed("pause")):
		toggle_pause()

#Send signal to pause menu scene
func toggle_pause():
	game_paused = !game_paused
	toggle_game_paused.emit(game_paused)

func _on_main_menu_new_game_okay_button_pressed(user_input: String):
	user_name = user_input
	get_tree().change_scene_to_file("res://Scene/global_game_manager.tscn")



#Ensure save path exists
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

#Get paths to nodes for reference
func _get_node_reference(node_path: NodePath, node_name: String):
	if node_name == "Player":
		player = node_path
	
	if node_name == "GameWorld":
		game_world = node_path
	
	if node_name == "MainMenu":
		main_menu = node_name



func load_data(path: String):
	if FileAccess.file_exists(path):
		#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		var file = FileAccess.open(path, FileAccess.READ)
		if file == null:
			print(FileAccess.get_open_error)
			return
			
		var json = JSON.new()
		json.parse(file.get_line())
		var save_dict = json.get_data() as Dictionary
		file.close()
		
		var player = get_node(player)
		
		user_name = save_dict.player_name
		player.position = str_to_var(save_dict.player.position)
		player.hud.health = str_to_var(save_dict.player.health)
		player.hud.lives = str_to_var(save_dict.player.lives)
		player.animated_sprite.rotation = str_to_var(save_dict.player.rotation)
		
		get_tree().call_group("Enemy", "queue_free")
		
		var game = get_node(game_world)
		
#		for enemy_config in save_dict.enemies:
#			var enemy = preload("res://Scene/enemy_bot_wheel.tscn").instantiate()
#			enemy.position = str_to_var(enemy_config.position)
#			game_world.add_child(enemy)
		
#		var data = JSON.parse_string(content)
#		if data == null:
#			printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
#			return
#
		
		
#		player_data = 
#		player_data.health = data.player_data.health
#		player_data.global_position = Vector2(data.player_data.global_position.x, data.player_data.global_position.y)
		
	else:
		printerr("Cannot open non-existent file at %s!" % [path])
