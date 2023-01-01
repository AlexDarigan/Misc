extends Area2D

const SCREEN_WIDTH: int = 320
const MOVE_SPEED: float = 500.0

func _process(delta: float) -> void:
	position += Vector2(MOVE_SPEED * delta, 0.0)
	if position.x > SCREEN_WIDTH:
		queue_free()


func _on_shot_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		queue_free()
