extends Area2D

signal evaporated
const DO_NOT_RESET = false
export var cool_rate: float = 12
var _player: Player
onready var splash: AudioStreamPlayer = $Splash
onready var player: AnimationPlayer = $AnimationPlayer
onready var particles: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	player.play("Appear")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Evaporate":
		emit_signal("evaporated")
		queue_free()

func _process(delta: float) -> void:
	if _player:
		_player.temp -= cool_rate * delta

func _on_Puddle_body_entered(body: Node) -> void:
	if body is Player:
		_player = body
		splash.play()
		player.play("Evaporate")
		particles.emitting = true 
		
		
func _on_Puddle_body_exited(body: Node) -> void:
	if body is Player:
		_player = null
		player.stop(DO_NOT_RESET)
