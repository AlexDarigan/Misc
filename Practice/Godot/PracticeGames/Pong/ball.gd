extends KinematicBody2D
class_name Ball

export(int) var speed: int = 200
export(float) var boost: float = 1.0
enum Directions { LEFT = -1, RIGHT = 1 }
var direction: Vector2 = Vector2(-1, .5)
onready var Bounce: AudioStreamPlayer = $Bounce

func _process(delta) -> void:
	var collision: KinematicCollision2D = move_and_collide(direction * speed * delta * boost)
	if collision:
		_on_collision(collision)
		Bounce.play()
		
func _on_collision(collision: KinematicCollision2D) -> void:
	if collision.collider is Paddle:
		direction.x = -direction.x
		boost += 0.2
	elif collision.collider is StaticBody2D: # Walls
		direction.y = -direction.y
