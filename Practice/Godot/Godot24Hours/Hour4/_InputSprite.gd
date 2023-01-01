extends Sprite

export var movement_speed = 50 # pixels per second
var input_direction = 0

func _process(delta: float) -> void:
	position.x += input_direction * movement_speed * delta
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		input_direction = -1
	elif event.is_action_pressed("ui_right"):
		input_direction = +1
		
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		input_direction = 0
