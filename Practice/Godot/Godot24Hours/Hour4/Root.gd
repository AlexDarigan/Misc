extends Node2D


const MOVEMENT_SPEED = 50 # pixels per second

var sprite_node: Sprite

func _ready() -> void:
	sprite_node = get_node("Sprite")
	
func _process(delta: float) -> void:
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction = 1
		
	# move child
	sprite_node.position.x += direction * MOVEMENT_SPEED * delta
