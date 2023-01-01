extends Node2D


func _ready() -> void:
	$Button.connect("pressed", self, "_on_Button_pressed")
	
func _on_Button_pressed() -> void:
	print("Button got pressed")
