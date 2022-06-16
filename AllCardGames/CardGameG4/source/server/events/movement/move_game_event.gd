extends GameEvent
class_name MoveGameEvent

var _card: ServerCard
var _controller: ServerPlayer

func _init(card: ServerCard) -> void:
	_controller = card.controller
	_card = card
