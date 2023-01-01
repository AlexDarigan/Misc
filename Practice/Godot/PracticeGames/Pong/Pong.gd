extends Node

var player_score: int = 0
var comp_score: int = 0
onready var PlayerScore: Label = $PlayerScore
onready var CompScore: Label = $CompScore
onready var Goal: AudioStreamPlayer = $Goal


func _ready() -> void:
	$PlayerGoal.connect("body_entered", self, "_on_ball_entered_player_goal")
	$CompGoal.connect("body_entered", self, "_on_ball_entered_comp_goal")
	
func _on_ball_entered_player_goal(body) -> void:
	if body.name == "Ball":
		Goal.play()
		comp_score += 1
		CompScore.text = comp_score as String
		reset(body as Ball)
	
func _on_ball_entered_comp_goal(body) -> void:
	if body.name == "Ball":
		Goal.play()
		player_score += 1
		PlayerScore.text = player_score as String
		reset(body as Ball)
		
func reset(ball: Ball) -> void:
	ball.boost = 1
	ball.position = $Origin.position
	ball.direction = -ball.direction
