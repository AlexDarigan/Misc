extends PlayerState


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		var input_direction: Vector3 = _parent.get_input_direction()
		if input_direction:
			_state_machine.transition_to("Move/Run")
		else:
			_state_machine.transition_to("Move/Idle")
	
func enter(msg: Dictionary = {}) -> void:
	match msg:
		{"velocity": var v, "jump_impulse": var ji}:
			_parent.velocity = v + Vector3(0.0, ji, 0.0)
	skin.transition_to(skin.States.AIR)
	_parent.enter(msg)
	
func exit() -> void:
	_parent.exit()
