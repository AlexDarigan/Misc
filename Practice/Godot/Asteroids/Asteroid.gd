extends KinematicBody2D

export var speed: int = 200
var velocity = Vector2.ZERO

func _physics_process(delta) -> void:
#	velocity = Vector2.UP.rotated(rotation)
	move_and_collide(velocity * delta * speed)
