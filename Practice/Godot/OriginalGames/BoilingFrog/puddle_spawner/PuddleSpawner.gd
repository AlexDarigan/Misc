extends Path2D

export(PackedScene) var PuddleScene: PackedScene
export var max_puddles: int = 3
var total_puddles: int = 0

func _on_Timer_timeout() -> void:
	if total_puddles == max_puddles:
		return
	randomize()
	var puddle = PuddleScene.instance()
	puddle.position = curve.get_point_position(randi() % curve.get_point_count())
	puddle.position.x = clamp(puddle.position.x, 50, get_viewport().size.x - 100)
	puddle.position.y = clamp(puddle.position.y, 100, get_viewport().size.y - 32)
	puddle.connect("evaporated", self, "_on_puddle_evaporated")
	add_child(puddle)
	total_puddles += 1
	
func _on_puddle_evaporated() -> void:
	print("evapo")
	total_puddles -= 1
	
