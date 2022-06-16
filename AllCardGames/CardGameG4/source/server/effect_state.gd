extends RefCounted
class_name EffectState

var card: ServerCard
var player: ServerPlayer:
	get: return card.owner
var controller: ServerPlayer:
	get: return card.controller
var opponent: ServerPlayer:
	get: return card.controller.opponent
var cards: Array = []
var _events: Array = []
var _op_codes: Array
var _max_size: int
var _cursor: int = 0

func _init(_owner: ServerCard, op_codes: Array) -> void:
	card = _owner
	_op_codes = op_codes
	_max_size = op_codes.size()
	
func execute() -> Array:
	while !is_done():
		VirtualMachine.get_operation(_op_codes[_cursor]).call(self)
		_cursor += 1;
	return _events
	
func add_event(event: GameEvent) -> void:
	_events.append(event)
	
func jump(i: int) -> void:
	_cursor += (i - 1)
	
func push(i: int) -> void:
	_op_codes.append(i)
	
func next() -> int:
	_cursor += 1
	return _op_codes[_cursor]
	
func pop_back() -> int:
	return _op_codes.pop_back()
	
func _pop(i: int) -> int:
	return _op_codes.pop_at(i)
	
func is_done() -> bool:
	return _cursor == _max_size
