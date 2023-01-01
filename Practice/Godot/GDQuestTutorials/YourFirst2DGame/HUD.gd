extends CanvasLayer

signal start_game

onready var ScoreLabel: Label = $ScoreLabel
onready var Message: Label = $Message
onready var MessageTimer: Timer = $MessageTimer
onready var StartButton: Button = $StartButton

func show_message(text: String) -> void:
	Message.text = text
	Message.show()
	MessageTimer.start()
	
func show_game_over() -> void:
	show_message("Game Over")
	yield(MessageTimer, "timeout")
	Message.text = "Dodge the\nCreeps!"
	# Make one shot timer and wait for it to finish
	yield(get_tree().create_timer(1), "timeout")
	StartButton.show()
	
func update_score(score: int) -> void:
	ScoreLabel.text = str(score)

func _on_StartButton_pressed() -> void:
	StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout() -> void:
	Message.hide()
