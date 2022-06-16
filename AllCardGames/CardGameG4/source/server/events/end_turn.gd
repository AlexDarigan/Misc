extends GameEvent
class_name EndTurnEvent

var _player: ServerPlayer

func _init(player: ServerPlayer) -> void:
	_player = player
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_player.id, Enums.CommandId.EndTurn)
	queue.call(_player.opponent.id, Enums.CommandId.EndTurn)
