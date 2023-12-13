extends Node

signal pop_up_game_saved


@onready var game_saved : bool = false:
	get:
		return game_saved
	set(value):
		game_saved = value


func _ready():
	#Set root node to process only when paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	


func save_data(path: String):
	#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error)
		return
	
	var player = get_node(GlobalScript.player)
	
	var save_dict = {
		player = {
			player_name = GlobalScript.user_name,
			position = var_to_str(player.position),
			health = var_to_str(player.get_player_health()),
			lives = var_to_str(player.get_player_lives()),
			rotation = var_to_str(player.animated_sprite.rotation)
		},
		enemies = []
	}
	
	for enemy in get_tree().get_nodes_in_group(&"Enemy"):
		save_dict.enemies.push_back({
			position = var_to_str(enemy.position),
		})
		
	
	file.store_line(JSON.stringify(save_dict))
	
	game_saved = true
	display_game_saved()


func display_game_saved():
	if game_saved == true:
		game_saved = false
		var game_world = get_node(GlobalScript.game_world)
		game_world._on_pop_up_game_saved()



#Button from game saved popup
func _on_okay_button_pressed():
	var game_world = get_node(GlobalScript.game_world)
	game_world.pop_up_game_saved_okay()



