extends Button

export(PackedScene) var FallSprite

func _ready() -> void:
	connect("pressed", self, "_on_pressed")
	
func _on_pressed() -> void:
	var s = FallSprite.instance()
	s.position = Vector2(0, 20)
	add_child(s)
