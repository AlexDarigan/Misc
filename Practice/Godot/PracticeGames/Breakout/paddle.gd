extends KinematicBody2D

export(int) var speed: int = 200
enum Directions { UP = -1, DOWN = 1 }
var direction: int = Directions.UP

func _process(delta: float) -> void:
	direction = 0
	if Input.is_key_pressed(KEY_W):
		direction = Directions.UP
	if Input.is_key_pressed(KEY_S):
		direction = Directions.DOWN
	move_and_collide(Vector2(0, direction * speed * delta))
