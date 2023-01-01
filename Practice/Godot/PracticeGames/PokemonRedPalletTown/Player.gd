extends KinematicBody2D

export var speed: int = 500

func _process(delta: float) -> void:
	var direction: Vector2 = Vector2(0, 0)
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	move_and_collide(direction.normalized() * speed * delta)
