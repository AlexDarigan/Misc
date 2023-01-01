extends StaticBody2D
class_name Brick

export(Color) var color: Color setget _set_color
onready var brick_color: ColorRect = $ColorRect

func _set_color(new_color: Color) -> void:
	color = new_color
	if is_inside_tree():
		brick_color.color = color

func _ready() -> void:
	brick_color.color = color


