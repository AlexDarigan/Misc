extends KinematicBody2D

export var direction: Vector2 = Vector2.LEFT
export var speed: float = 300
export var default_boost: float = 1.1
export var boost_rate: float = 0.2
onready var bounce: AudioStreamPlayer = $Bounce
onready var origin: Vector2 = get_viewport_rect().size / 2
var boost = default_boost

func _ready() -> void:
	launch()

func launch() -> void:
	position = origin
	randomize()
	direction.y = rand_range(-1, 1)
	
func _physics_process(delta: float) -> void:
	var velocity: Vector2 = direction * speed * boost * delta
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision == null:
		return
	elif collision.collider is StaticBody2D:
		direction.y = -direction.y
	elif collision.collider is Paddle:
		boost += boost_rate
		direction.x = -direction.x
		direction.y = rand_range(-1, 1)

	bounce.play()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	direction.x = -direction.x
	boost = default_boost
	launch()
