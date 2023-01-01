extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		prints("Button", event.button_index, " is pressed at ", str(event.position))
	if event is InputEventMouseMotion:
		print("Mouse moved to", str(event.position))
