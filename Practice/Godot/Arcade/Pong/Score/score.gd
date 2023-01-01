extends Label
class_name Score

var value: int = 0


func _on_Goal_scored(_body: Node) -> void:
	value += 1
	text = value as String
