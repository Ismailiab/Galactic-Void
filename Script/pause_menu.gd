extends Control

@onready var main_pause_menu = $Panel/MainPauseMenu
@onready var settings_menu = $Panel/SettingsMenu
@onready var game_controls_menu = $Panel/GameControls
@onready var popup_quit_confirmation = $Panel/PopUpQuitConfirmation
@onready var settings_button = $Panel/MainPauseMenu/VBoxContainer/SettingsButton
@onready var settings_back_button  = $Panel/SettingsMenu/BackButton
@onready var save_game_button = $Panel/MainPauseMenu/VBoxContainer/SaveGameButton
@onready var game_controls_button = $Panel/MainPauseMenu/VBoxContainer/GameControlsButton
@onready var game_controls_back_button = $Panel/GameControls/BackButton
@onready var popup_yes_button = $Panel/PopUpQuitConfirmation/Panel/VBoxContainer/HBoxContainer/YesButton
@onready var popup_cancel_button = $Panel/PopUpQuitConfirmation/Panel/VBoxContainer/HBoxContainer/CancelButton
@onready var quit_button = $Panel/MainPauseMenu/QuitButton
@onready var resume_button = $Panel/MainPauseMenu/ResumeButton

func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	#Connect buttons to signals
	settings_button.pressed.connect(self._on_settings_button_pressed)
	game_controls_button.pressed.connect(self._on_game_controls_button_pressed)
	settings_back_button.pressed.connect(self._on_settings_back_button_pressed)
	game_controls_back_button.pressed.connect(self._on_game_controls_back_button_pressed)
	quit_button.pressed.connect(self._on_quit_button_pressed)
	resume_button.pressed.connect(self._on_resume_button_pressed)
	popup_cancel_button.pressed.connect(self._on_popup_cancel_buttton_pressed)
	popup_yes_button.pressed.connect(self._on_popup_yes_button_pressed)
	
	settings_menu.hide()
	game_controls_menu.hide()
	popup_quit_confirmation.hide()
		
	#Connect signal from global script
	GlobalScript.connect("toggle_game_paused", _on_toggle_game_paused)

func _on_toggle_game_paused(is_paused : bool):
	if (is_paused):
		show()
	else:
		hide()

func _on_settings_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_pause_menu.hide()
	settings_menu.show()

func _on_settings_back_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	settings_menu.hide()
	main_pause_menu.show()

func _on_game_controls_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_pause_menu.hide()
	game_controls_menu.show()

func _on_game_controls_back_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	game_controls_menu.hide()
	main_pause_menu.show()

func _on_resume_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	GlobalScript.toggle_pause()
	GlobalScript.game_paused = false
	

#Quit from game to main menu
func _on_quit_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	main_pause_menu.hide()
	popup_quit_confirmation.show()
	

func _on_popup_cancel_buttton_pressed():
	AudioPlayer.play_player_sfx("button_click")
	popup_quit_confirmation.hide()
	main_pause_menu.show()

func _on_popup_yes_button_pressed():
	AudioPlayer.play_player_sfx("button_click")
	hide()
	GlobalScript.toggle_pause()
	get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
