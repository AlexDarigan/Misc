extends Node

func _ready() -> void:
	$Thermometer._player = $Player

# warning-ignore:unused_argument
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("reset"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
		
# warning-ignore:unused_argument
func _process(delta) -> void:
	if $Player.temp >= 100:
		game_over()
		
func game_over() -> void:
	set_process(false)
	$CanvasLayer/GameOverLabel.visible = true
	$CanvasModulate.visible = true
	$Score.set_process(false)
	$CanvasLayer/GameOverLabel.text += "\n\nScore: " + $Score.text
	$PuddleSpawner.set_process(false)
