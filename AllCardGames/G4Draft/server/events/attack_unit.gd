extends Event
class_name AttackUnit

var attacker: Card
var defender: Card

func _init(_attacker: Card, _defender: Card) -> void:
	attacker = _attacker
	defender = _defender
