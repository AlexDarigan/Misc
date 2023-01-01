extends Node


export(PackedScene) var MobScene: PackedScene
onready var ScoreTimer: Timer = $ScoreTimer
onready var MobTimer: Timer = $MobTimer
onready var StartTimer: Timer = $StartTimer
onready var Player: Area2D = $Player
onready var StartPosition: Position2D = $StartPosition
onready var Spawner: PathFollow2D = $MobPath/MobSpawnLocation
onready var HUD: CanvasLayer = $HUD
var score: int = 0


func _ready() -> void:
	randomize()

func game_over():
	$Music.stop()
	$DeathSound.play()
	ScoreTimer.stop()
	MobTimer.stop()
	HUD.show_game_over()
	
func new_game() -> void:
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	score = 0
	Player.start(StartPosition.position)
	HUD.update_score(0)
	HUD.show_message("Get Ready")
	StartTimer.start()

func _on_StartTimer_timeout():
	ScoreTimer.start()
	MobTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	HUD.update_score(score)

func _on_MobTimer_timeout():
	var mob: RigidBody2D = MobScene.instance()
	
	# Choose random spawn point on spawn path
	Spawner.offset = randi()
	
	# Set mobs direction perpendicular to the path direction (see note below)
	var direction: float = Spawner.rotation + PI / 2
	
	# Set mob's position to a random Location (???)
	mob.position = Spawner.position
	
	# Randomness to direction
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose velocity for mob
	var velocity: Vector2 = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Finally spawn mob as child of main scene
	add_child(mob)

# WHY PI?
# Why PI? In functions requiring angles, Godot uses radians, not degrees. Pi represents a half turn in radians, 
# about 3.1415 (there is also TAU which is equal to 2 * PI). If you're more comfortable working with degrees, 
# you'll need to use the deg2rad() and rad2deg() functions to convert between the two.
