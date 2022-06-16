extends GameEvent
class_name ResolveEvent

var _player: ServerPlayer
var _card: ServerCard

func _init(player: ServerPlayer, card: ServerCard = null) -> void:
	_player = player
	_card = card
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_player.id, Enums.CommandId.Resolve)
	queue.call(_player.opponent.id, Enums.CommandId.Resolve)
