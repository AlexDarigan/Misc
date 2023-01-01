extends Area2D


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body) -> void:
	if body is Ball:
		body.position = Vector2(512, 300)
		body.boost = 1
		randomize()
		body.direction.y = randf()
