extends Node

# The Pythagorean Theorem: square(a) + square(b) = square(c)
# Magnitude of a Vector: square_root(square(a) + square(b)) = Magnitude
# The magnitude is the length of the hypotenuse (ie c) 

func _ready() -> void:
	print(Vector2(3, 4).length())
	print(3.0 / 5.0)
	print(4.0 / 5.0)
	print(Vector2(3, 4).normalized() * 1)
	print(Vector2(3, 4)/ Vector2(3,4).length())
	var n = Vector2(-3, -4).normalized()
	print(-n.dot(-n))
	
	[-1, 1]
