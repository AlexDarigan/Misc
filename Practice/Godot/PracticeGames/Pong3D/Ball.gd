extends KinematicBody

export var speed: int = 4
export var velocity: Vector3 = Vector3(0, 0, 0)

func _process(delta) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if collision.collider is KinematicBody: # Paddle 
			velocity.x = -velocity.x
			velocity.y = rand_range(-1, 1)
		if collision.collider is StaticBody: # A Wall
			velocity.y = -velocity.y
