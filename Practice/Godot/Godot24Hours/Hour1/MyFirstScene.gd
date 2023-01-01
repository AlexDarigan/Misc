extends Node2D


func _on_Button_pressed() -> void:
	$Sprite.visible = not $Sprite.visible
