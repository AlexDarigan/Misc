extends KinematicBody2D
class_name Player

export var speed: int = 500
export var temp: float = 10
export var temp_rate: float = 10
var _velocity: Vector2 = Vector2.ZERO
onready var _bounds: Vector2 = Vector2(get_viewport().size.x - 100, get_viewport().size.y - 32)
onready var _sprite: AnimatedSprite = $AnimatedSprite
onready var _hop: AudioStreamPlayer = $Hop


func _process(delta: float) -> void:
	temp += temp_rate * delta
	
	_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		_velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		_velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		_velocity.x += 1
		_sprite.flip_h = true
	if Input.is_action_pressed("ui_left"):
		_velocity.x -= 1
		_sprite.flip_h = false
	
	if _velocity != Vector2(0, 0):
		_sprite.play("Jump")
		if not _hop.playing:
			_hop.play()
	else:
		_sprite.play("Idle")
	
	_velocity = move_and_slide(_velocity.normalized() * speed)
	position.x = clamp(position.x, 32.0, _bounds.x)
	position.y = clamp(position.y, 32.0, _bounds.y)
