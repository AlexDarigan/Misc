extends KinematicBody2D
class_name Paddle

enum Keys {
	UP = 16777232,
	DOWN = 16777234,
	W = 87,
	S = 83,
}

export(Keys) var key_up: int = Keys.W
export(Keys) var key_down: int = Keys.S
export var speed: int = 400

func _physics_process(delta: float) -> void:
	move_and_collide(_get_direction() * speed * delta)
	
func _get_direction() -> Vector2:
	if Input.is_key_pressed(key_up):
		return Vector2(0, -1)
	if Input.is_key_pressed(key_down):
		return Vector2(0, 1)
	return Vector2.ZERO
