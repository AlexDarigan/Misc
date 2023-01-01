extends Node


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		print("Holding Spacebar")
