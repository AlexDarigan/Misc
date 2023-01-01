extends KinematicBody

signal hit

# Speed in MPS / Meters per second
export(int) var speed: int = 14

# Fall acceleration, while in the air, squared
export(int) var fall_acceleration: int = 75
export(int) var jump_impulse: int = 20

# Vertical impulse applied to the character upon bouncing over a mob in meters per second
export(int) var bounce_impulse: int = 16

# Speed + Direction
var velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	# Reset direction
	var direction: Vector3 = Vector3.ZERO
	
	# Note: Y is up, XZ is ground
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4
	else:
		$AnimationPlayer.playback_speed = 1
		
		
	# NOTE: Horizontal Velocity needs to be calculated seperately from Vertical Velocity..
	# ..which is why the following isn't
	
	# Ground Velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Vertical Velocity
	velocity.y -= fall_acceleration * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	
	# Moving the character
	# (If we don't store the velocity here, the character's force would go up and shake)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	for index in range(get_slide_count()):
		# Check every collision that occurred this frame
		var collision: KinematicCollision = get_slide_collision(index)
		if collision.collider.is_in_group("mobs"):
			var mob = collision.collider
			# Check that the collision is from above
			if Vector3.UP.dot(collision.normal) > 0.1:
				# Squash it if we are
				mob.squash()
				velocity.y = bounce_impulse
	
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func _on_MobDetector_body_entered(body) -> void:
	die()

func die() -> void:
	emit_signal("hit")
	queue_free()

# A note on the pivot node
# Animations update the properties of the animated nodes every frame, overriding initial values.
# If we directly animated the Player node, it would prevent us from moving it in code. 
# This is where the Pivot node comes in handy: even though we animated the Character, 
# we can still move and rotate the Pivot and layer changes on top of the animation in a script.
