extends Control

signal leave_settings

@onready var back_button : Button = $BackButton

func _ready():
	#Connect back button pressed signal
	back_button.pressed.connect(self._settings_back_button_pressed)


func _settings_back_button_pressed():
	queue_free()
	emit_signal("leave_settings")
