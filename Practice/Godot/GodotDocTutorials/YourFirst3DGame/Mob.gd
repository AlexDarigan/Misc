extends KinematicBody

signal squashed
export(int) var min_speed: int = 10
export(int) var max_speed: int = 18

var velocity: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	move_and_slide(velocity)

func initialize(start_position: Vector3, player_position: Vector3) -> void:
	# Make the mob look at the player
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	# Random rotation around y to prevent beelining for the player
	rotate_y(rand_range(-PI / 4, PI / 4))
	
	var random_speed: int = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	
	# Rotate velocity based on mob's rotation to move in the direction
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	$AnimationPlayer.playback_speed = random_speed / min_speed


func _on_VisibilityNotifier_screen_exited():
	queue_free()

func squash() -> void:
	emit_signal("squashed")
	queue_free()
