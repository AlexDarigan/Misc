extends RefCounted
class_name Command

func execute(board) -> void:
	var t: Tween = board.get_tree().create_tween()
	t.tween_callback(func(): pass)
	board.effects.gfx = t
	setup(board)
	t.play()
	await t.finished
	t.kill()
	
func setup(board) -> void:
	push_warning("Called Abstract Method")

#gfx = get_tree().create_tween()
#	gfx.tween_callback(Callable()) # prevents auto-start erros
#	gfx.stop()
#	sfx = AudioStreamPlayer.new()
#	add_child(sfx)
