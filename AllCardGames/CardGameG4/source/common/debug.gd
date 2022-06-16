extends Node


func _input(event: InputEventKey) -> void:
	if event.is_pressed():
		match event.scancode:
			KEY_F:
				OS.window_fullscreen = not OS.window_fullscreen
				OS.window_size = Vector2i(1920, 1080)
			KEY_1:
				OS.window_size = Vector2i(1920, 1080)
			KEY_2:
				OS.window_size = Vector2i(1280, 720)
			KEY_3:
				OS.window_size = Vector2i(854, 480)
			KEY_4:
				OS.window_size = Vector2i(640, 360)
