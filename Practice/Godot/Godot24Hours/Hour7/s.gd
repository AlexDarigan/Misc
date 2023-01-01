extends Sprite

export var speed: float = 200

func _process(delta: float) -> void:
	var direction = Vector2(0, 0)
	if Input.is_key_pressed(KEY_UP):
		direction.y -= 1
	if Input.is_key_pressed(KEY_DOWN):
		direction.y += 1
	if Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1
	
	direction = direction.normalized()
	direction *= speed * delta
	translate(direction)
