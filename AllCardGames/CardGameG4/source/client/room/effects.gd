extends Node
class_name Effects

var gfx: Tween
var sfx: AudioStreamPlayer

func _ready() -> void:
	gfx = get_tree().create_tween()
	gfx.tween_callback(Callable()) # prevents auto-start erros
	gfx.stop()
	sfx = AudioStreamPlayer.new()
	add_child(sfx)
	
func play_sound() -> void:
	pass
	
func move_card() -> void:
	pass
	
func update_zone() -> void:
	pass
	
func start() -> void:
	pass
	
func clear() -> void:
	pass
