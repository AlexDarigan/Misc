extends Node
class_name Card

enum States {
	None, Deploy, SetFaceDown, AttackUnit, AttackPlayer, Activate
}

var id: int
var possessor: Player
var controller: Player
var is_ready: bool = false
var title: String
var power: int = 0
var setcode: String
var card_type: CardType
var faction: Faction
var zone: Array[Card]
var state: States = States.None

func update() -> void:
	state = States.None
	if controller.state == Player.States.IdleTurnPlayer:
		if can_be_deployed():
			state = States.Deploy
		elif can_be_set_facedown():
			state = States.SetFaceDown
		elif can_attack_unit():
			state = States.AttackUnit
		elif can_attack_player():
			state = States.AttackPlayer
		elif can_be_activated():
			state = States.Activate
	elif controller.state == Player.States.Active and can_be_activated():
		state = States.Activate

func can_be_deployed() -> bool:
	return controller.hand.has(self) and card_type == load("res://server/card/unit.tres")
	
func can_be_set_facedown() -> bool:
	return controller.hand.has(self) and card_type == load("res://server/card/support.tres")
	
func can_attack_unit() -> bool:
	return controller.units.has(self) and is_ready and not controller.opponent.units.is_empty()
	
func can_attack_player() -> bool:
	return controller.units.has(self) and is_ready and controller.opponent.units.is_empty()
	
func can_be_activated() -> bool:
	return controller.supports.has(self) and is_ready
	
func activate():
	push_error("Activation not implemented")
