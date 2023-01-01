extends PlayerState

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
func process(delta: float) -> void:
	pass
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() or player.is_on_wall():
		if _parent.velocity.length() < 0.01:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")
	
	
func enter(msg: Dictionary = {}) -> void:
	skin.transition_to(skin.States.RUN)
	_parent.enter(msg)
	
func exit() -> void:
	_parent.exit()
