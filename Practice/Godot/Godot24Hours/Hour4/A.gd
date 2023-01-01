extends Node2D

func _ready() -> void:
	$"../B".test_method("This is a test")
	get_node("../B").test_method("Hello from A")
