extends Command

var _state: Enums.States

func _init(state) -> void:
	_state = state[0]
	
func setup(board) -> void:
	print(_state, " is state")
	board.player.state = _state
	board.table.set_state(_state)
