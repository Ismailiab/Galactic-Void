extends Control



@export var save_load : NodePath

@onready var main_menu_options = $MainMenuOptions
@onready var load_menu  = $LoadGameMenu
@onready var settings_menu = $SettingsMenu
@onready var game_controls_menu = $GameControls
@onready var new_game_button = $MainMenuOptions/VBoxContainer/NewGameButton
@onready var load_button  = $MainMenuOptions/VBoxContainer/LoadButton
@onready var settings_button  = $MainMenuOptions/VBoxContainer/SettingsButton
@onready var game_controls_button = $MainMenuOptions/VBoxContainer/GameControlsButton
@onready var settings_back_button  = $SettingsMenu/BackButton
@onready var load_back_button = $LoadGameMenu/BackButton
@onready var game_controls_back_button = $GameControls/BackButton
@onready var quit_button = $MainMenuOptions/QuitButton
@onready var new_game_panel = $NewGamePanel



func _ready():
	#Hide the load game and settings menu on start
	load_menu.hide()
	settings_menu.hide()
	game_controls_menu.hide()
	new_game_panel.hide()
	
	
	#Connect pressed signals to button functions
	new_game_button.pressed.connect(self._on_new_game_button_pressed)
	load_button.pressed.connect(self._on_load_button_pressed)
	settings_button.pressed.connect(self._on_settings_button_pressed)
	game_controls_button.pressed.connect(self._on_game_controls_button_pressed)
	settings_back_button.pressed.connect(self._on_settings_back_button_pressed)
	load_back_button.pressed.connect(self._on_load_back_button_pressed)
	game_controls_back_button.pressed.connect(self._on_game_controls_back_button_pressed)
	quit_button.pressed.connect(self._on_quit_button_pressed)
	
	GlobalScript._get_node_reference(get_path(), "MainMenu")

#Start new game
func _on_new_game_button_pressed():
	new_game_panel.show()
	main_menu_options.hide()

func _on_new_game_back_button_pressed():
	new_game_panel.hide()
	main_menu_options.show()

#Functions to show menus
func _on_load_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_menu_options.hide()
	load_menu.show()

func _on_settings_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_menu_options.hide()
	settings_menu.show()

func _on_game_controls_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_menu_options.hide()
	game_controls_menu.show()

#Functions to use back button to navigate back
func _on_settings_back_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	settings_menu.hide()
	main_menu_options.show()

func _on_load_back_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	load_menu.hide()
	main_menu_options.show()

func _on_game_controls_back_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	game_controls_menu.hide()
	main_menu_options.show()

#Quit from main menu
func _on_quit_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	get_tree().quit()
	
	
	


