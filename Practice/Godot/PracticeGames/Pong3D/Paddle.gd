extends KinematicBody

export var speed: int = 4
export var is_player: bool = true 

func _process(delta) -> void:
	var direction = Vector3(0, 0, 0)
	if is_player:
		if Input.is_key_pressed(KEY_W):
			direction.y = 1
		if Input.is_key_pressed(KEY_S):
			direction.y = -1
	else:
		if Input.is_key_pressed(KEY_UP):
			direction.y = 1
		if Input.is_key_pressed(KEY_DOWN):
			direction.y = -1
	move_and_collide(direction * delta * speed)
