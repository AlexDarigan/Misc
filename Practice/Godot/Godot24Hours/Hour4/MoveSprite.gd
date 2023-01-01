extends Sprite

const MOVEMENT_SPEED = 50 # Pixels per second


func _process(delta: float) -> void:
	var input_direction = 0 # 0 is no movement, 1 is right, 1 is -left
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		
	position.x += input_direction * MOVEMENT_SPEED * delta
