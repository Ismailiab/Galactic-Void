extends Control

@onready var user_name_input = $Panel/UserNameInput
@onready var input_label = $Panel/NameInputLabel
@onready var okay_button = $Panel/OkayButton

var user_name : String = ""


func _ready():
	#set focus to input
	user_name_input.grab_focus()
	


func _on_okay_button_pressed():
	if validate_user_input():
		print (user_name)
		GlobalScript._on_main_menu_new_game_okay_button_pressed(user_name)
	else:
		input_label.text = "*Invalid name entry! \n Only letters allowed \n Please enter your name:"

func validate_user_input():
	#Regex object to ensure the user name is a-z
	var regex = RegEx.new()
	#look for space in name with letters only
	regex.compile("[A-Za-z]+\\s+[A-Za-z]+")
	var name_space = regex.search(user_name_input.text)
	if name_space:
		user_name = name_space.get_string().replace(" ", "")
		return true
	elif !name_space:
		#recompile and check for letters only
		regex.compile("[A-Za-z]+")
		var input = regex.search(user_name_input.text)
		if input:
			user_name = input.get_string()
			return true
	



