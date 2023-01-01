extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var v = Vector2(0, 90)
	var v2 = Vector2(90, 90)
	print(v.dot(v2))
