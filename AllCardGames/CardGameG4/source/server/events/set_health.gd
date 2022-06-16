extends GameEvent
class_name SetHealthEvent

var _new_health: int
var _damaged: ServerPlayer

func _init(damaged: ServerPlayer) -> void:
	_new_health = damaged.health
	_damaged = damaged
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_damaged.id, Enums.CommandId.SetHealth, Enums.Who.Player, _new_health)
	queue.call(_damaged.opponent.id, Enums.CommandId.SetHealth, Enums.Who.Rival, _new_health)
