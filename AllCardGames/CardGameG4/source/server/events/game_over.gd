extends GameEvent
class_name GameOverEvent

const ISLOSER: bool = true # what?
var _loser: ServerPlayer

func _init(loser: ServerPlayer) -> void:
	_loser = loser
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_loser.id, Enums.CommandId.GameOver, ISLOSER)
	queue.call(_loser.opponent.id, Enums.CommandId.GameOver, not ISLOSER)
