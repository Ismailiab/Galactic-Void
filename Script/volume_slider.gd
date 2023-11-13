extends HSlider

@export var bus_name: String

var bus_index: int

func _ready():
	#Get bus index by name from AudioServer
	bus_index = AudioServer.get_bus_index(bus_name)
	
	#Set Volume when opening
	value_changed.connect(_on_sound_value_changed)
	
	#converting db to linear to initialize sliders with current volume
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_sound_value_changed(sound_value: float):
	#Linear_to_db is used to convert linear energy to decibels
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(sound_value))
