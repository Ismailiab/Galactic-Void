extends Area2D

@export var speed = 175

@onready var visible_notifier = $VisibleNotifier

#For bullet direction
var direction = Vector2()

func _ready():
	#Looking for "screen_exited signal
	visible_notifier.connect("screen_exited", _on_screen_exited)
	

func _physics_process(delta):
	#Move bullet in the given direciton
	global_position += direction * speed * delta

#Delete node when the frame ends to prevent accumulation
func _on_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("player_take_damage"):
		var damage = 15
		queue_free()
		body.player_take_damage(damage)
