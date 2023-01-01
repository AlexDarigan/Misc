extends Node2D

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var score = 0
const asteroid_scene = preload("res://asteroid.tscn")
var is_game_over = false

func _ready() -> void:
	get_node("player").connect("destroyed", self, "_on_player_destroyed")
	
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://stage.tscn")
	
func _on_player_destroyed() -> void:
	get_node("ui/retry").show()
	is_game_over = true


func _on_spawn_timer_timeout() -> void:
	var asteroid = asteroid_scene.instance()
	asteroid.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid.connect("score", self, "_on_player_score")
	add_child(asteroid)
	
func _on_player_score() -> void:
	score += 1
	get_node("ui/score").text = "Score: " + str(score)
