extends Node2D

var speed = 50

func _process(delta: float) -> void:
	position.y += speed * delta 
