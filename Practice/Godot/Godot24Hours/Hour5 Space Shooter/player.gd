extends Area2D

const SCREEN_WIDTH: int = 320
const SCREEN_HEIGHT: int = 180
const MOVE_SPEED: float = 150.0
const shot_scene = preload("res://shot.tscn")
var explosion_scene = preload("res://explosion.tscn")
var can_shoot = true
signal destroyed

func _process(delta: float) -> void:
	var direction = Vector2()
	if Input.is_key_pressed(KEY_UP):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		direction.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0
		
	position += (delta * MOVE_SPEED) * direction

	if position.x < 0.0:
		position.x = 0.0
	elif position.x > SCREEN_WIDTH:
		position.x = SCREEN_WIDTH
	if position.y < 0.0:
		position.y = 0.0
	elif position.y > SCREEN_HEIGHT:
		position.y = SCREEN_HEIGHT
		
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage = get_parent()
		var shot = shot_scene.instance()
		shot.position = position
		stage.add_child(shot)
		can_shoot = false
		get_node("reload_timer").start()


func _on_reload_timer_timeout() -> void:
	can_shoot = true


func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		queue_free()
		
		var stage = get_parent()
		var explosion = explosion_scene.instance()
		explosion.position = position
		stage.add_child(explosion)
		
		emit_signal("destroyed")
		
