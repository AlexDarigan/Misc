extends GameEvent
class_name AttackUnitEvent

var _attacker: ServerCard
var _defender: ServerCard

func _init(attacker: ServerCard, defender: ServerCard) -> void:
	_attacker = attacker
	_defender = defender
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_attacker.controller.id, Enums.CommandId.AttackUnit, _attacker.id, _defender.id)
	queue.call(_defender.controller.id, Enums.CommandId.AttackUnit, _attacker.id, _defender.id)
