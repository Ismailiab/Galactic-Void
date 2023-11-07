extends Control


@onready var main_menu_options : Control = $MainMenuOptions
@onready var load_menu : Control = $LoadGameMenu
@onready var new_game_button : Button = $MainMenuOptions/NewGameButton
@onready var load_button : Button = $MainMenuOptions/LoadButton
@onready var settings_button: Button = $MainMenuOptions/SettingsButton
@onready var back_button : Button = $LoadGameMenu/BackButton
@onready var quit_button : Button = $MainMenuOptions/QuitButton

#preload the settings scene
@onready var settings_scene = preload("res://Scene/settings_menu.tscn")

func _ready():
	#Hide the load game menu on start
	load_menu.hide()
	
#	#Connect pressed signals to button functions
	new_game_button.pressed.connect(self._on_new_game_button_pressed)
	load_button.pressed.connect(self._on_load_button_pressed)
	settings_button.pressed.connect(self._on_settings_button_pressed)
	back_button.pressed.connect(self._on_back_button_pressed)
	quit_button.pressed.connect(self._on_quit_button_pressed)

#Start new game
func _on_new_game_button_pressed():
	pass

#Show Load menu and hid main menu options
func _on_load_button_pressed():
	main_menu_options.hide()
	load_menu.show()

#Display the settings scene
func _on_settings_button_pressed():
	#Hide the main menu
	main_menu_options.hide()
	
	#Create an instance of the settings scene and add it
	var instance = settings_scene.instantiate()
	#Connect back button signal from settings_menu.gd
	instance.connect("leave_settings",_on_leave_settings)
	add_child(instance)

#Use back button to nabigate back
func _on_back_button_pressed():
	load_menu.hide()
	main_menu_options.show()

#Quit from main menu
func _on_quit_button_pressed():
	get_tree().quit()

#Display the main menu optsions when the settings back button is pressed
func _on_leave_settings():
	main_menu_options.show()
