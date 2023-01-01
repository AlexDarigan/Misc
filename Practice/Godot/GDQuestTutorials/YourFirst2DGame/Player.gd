extends Area2D

signal hit
export(int) var speed: int = 400
var screen_size: Vector2
onready var PlayerSprite: AnimatedSprite = $AnimatedSprite

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO #  The playerr's movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		# Velocity normalized -> Returns the vector scaled to unit length. Equivalent to v / v.length()
		# We normalize so player's move at same speed even if moving diagonally
		velocity = velocity.normalized() * speed
		PlayerSprite.play()
	else:
		PlayerSprite.stop()
		
	if velocity.x != 0:
		PlayerSprite.animation = "walk"
		PlayerSprite.flip_v = false
		PlayerSprite.flip_h = velocity.x < 0 # if our velocity is less than x, flip
	elif velocity.y != 0:
		PlayerSprite.animation = "up"
		PlayerSprite.flip_v = velocity.y > 0 # If our velocity is greater than y, flip v
		
	position += velocity * delta
	# Clamp makes sure value a is > than value b, and < value c (which in this case prevents our
	# player from going off screen)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	# (This prevents collision from being triggered more than once per hit)
	$CollisionShape2D.set_deferred("disabled", true)

func start(destination: Vector2) -> void:
	position = destination
	show()
	$CollisionShape2D.disabled = false
