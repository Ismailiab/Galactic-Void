extends Control


@onready var main_menu_options : Control = $MainMenuOptions
@onready var load_menu : Control = $LoadGameMenu
@onready var settings_menu : Control = $SettingsMenu
@onready var new_game_button : Button = $MainMenuOptions/NewGameButton
@onready var load_button : Button = $MainMenuOptions/LoadButton
@onready var settings_button : Button = $MainMenuOptions/SettingsButton
@onready var settings_back_button : Button = $SettingsMenu/BackButton
@onready var load_back_button : Button = $LoadGameMenu/BackButton
@onready var quit_button : Button = $MainMenuOptions/QuitButton



func _ready():
	#Hide the load game and settings menu on start
	load_menu.hide()
	settings_menu.hide()
	
	#Connect pressed signals to button functions
	new_game_button.pressed.connect(self._on_new_game_button_pressed)
	load_button.pressed.connect(self._on_load_button_pressed)
	settings_button.pressed.connect(self._on_settings_button_pressed)
	settings_back_button.pressed.connect(self._on_settings_back_button_pressed)
	load_back_button.pressed.connect(self._on_load_back_button_pressed)
	quit_button.pressed.connect(self._on_quit_button_pressed)

#Start new game
func _on_new_game_button_pressed():
	pass

#Functions to show menus
func _on_load_button_pressed():
	main_menu_options.hide()
	load_menu.show()

func _on_settings_button_pressed():
	main_menu_options.hide()
	settings_menu.show()

#Functions to use back button to navigate back
func _on_settings_back_button_pressed():
	settings_menu.hide()
	main_menu_options.show()

func _on_load_back_button_pressed():
	load_menu.hide()
	main_menu_options.show()

#Quit from main menu
func _on_quit_button_pressed():
	get_tree().quit()
