extends KinematicBody2D
class_name Ball

export(int) var speed: int = 200
enum Directions { RIGHT = -1, LEFT = 1 }
var direction: Vector2 = Vector2(Directions.RIGHT, 0.9)
onready var Bounce: AudioStreamPlayer = $Bounce
onready var Break: AudioStreamPlayer = $Break
var boost: float = 1.0 

func _process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(direction * speed * boost * delta)
	if collision:
		if collision.collider is Brick:
			randomize()
			direction.y = randf()
			direction = -direction
			Break.play()
			collision.collider.queue_free()
			boost += 0.5
		elif collision.collider is StaticBody2D and collision.collider.name == "Wall":
			direction.x = -direction.x
			Bounce.play()
		elif collision.collider is StaticBody2D:
			direction.y = -direction.y
			Bounce.play()
		elif collision.collider is KinematicBody2D:
			direction.x = -direction.x
			Bounce.play()
