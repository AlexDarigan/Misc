extends GameEvent
class_name AttackPlayerEvent

var _attacker: ServerCard

func _init(attacker: ServerCard) -> void:
	_attacker = attacker
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_attacker.controller.id, Enums.CommandId.AttackPlayer, _attacker.id)
	queue.call(_attacker.controller.id, Enums.CommandId.AttackPlayer, _attacker.id)
