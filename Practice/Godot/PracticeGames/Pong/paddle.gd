extends KinematicBody2D
class_name Paddle

export var is_player: bool = true
export var speed: int = 200
enum Directions { DOWN = 1, UP = -1 }
var direction: int = Directions.UP

func _process(delta) -> void:
	direction = 0
	if is_player:
		_player_input()
	else:
		_comp_input()
	move_and_collide(Vector2(0, direction * speed * delta))
	
func _player_input() -> void:
	if Input.is_key_pressed(KEY_S):
		direction = Directions.DOWN
	if Input.is_key_pressed(KEY_W):
		direction = Directions.UP

func _comp_input() -> void:
	if Input.is_key_pressed(KEY_DOWN):
		direction = Directions.DOWN
	if Input.is_key_pressed(KEY_UP):
		direction = Directions.UP
