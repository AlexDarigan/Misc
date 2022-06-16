extends RefCounted
class_name ServerCard

var id: int = 0:
	set(value): id = value if id == 0 else id

var owner: ServerPlayer
var state: Enums.CardStates = Enums.CardStates.None
var card_type: Enums.CardTypes
var controller: ServerPlayer
var faction: Enums.Factions
var is_ready: bool = false
var power: int
var setcode: String
var skill: CardEffect
var title: String
var zone: Array # User-Defined-Class?
	
func _init(_id: int, _owner) -> void:
	id = _id
	# Figure out how to handle cyclic references? (Maybe an id instead, or callable?)
	owner = _owner
	controller = _owner
	
func update() -> void:
	state = Enums.CardStates.None
	if controller.state == Enums.States.IdleTurnPlayer:
		if _can_be_deployed():
			state = Enums.CardStates.Deploy
		elif _can_be_set_facedown():
			state = Enums.CardStates.SetFaceDown
		elif _can_attack_unit():
			state = Enums.CardStates.AttackUnit
		elif _can_attack_player():
			state = Enums.CardStates.AttackPlayer
		elif _can_be_activated():
			state = Enums.CardStates.Activate
	elif controller.state == Enums.States.Active && _can_be_activated():
		state = Enums.CardStates.Activate
		
func _can_be_deployed() -> bool:
	return controller.hand.has(self) && card_type == Enums.CardTypes.Unit
	
func _can_be_set_facedown() -> bool:
	return controller.hand.has(self) && card_type == Enums.CardTypes.Support
		
func _can_attack_unit() -> bool:
	return controller.units.has(self) && is_ready && controller.opponent.units.size() > 0
	
func _can_attack_player() -> bool:
	return controller.units.has(self) && is_ready && controller.opponent.units.is_empty()
	
func _can_be_activated() -> bool:
	return controller.supports.has(self) and is_ready
	
func activate() -> EffectState:
	return EffectState.new(self, skill._op_codes)
