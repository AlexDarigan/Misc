extends Sprite


func _ready() -> void:
	var rotate_matrix = Transform2D().rotated(deg2rad(90))
	var scale_matrix = Transform2D().scaled(Vector2(2, 2))
	var translate_matrix = Transform2D().translated(Vector2(0, 0))
	var combined = translate_matrix * rotate_matrix * scale_matrix
	transform *= combined.affine_inverse()
