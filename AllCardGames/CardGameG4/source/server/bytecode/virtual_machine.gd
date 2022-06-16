extends Node

const OWNER: int = 2
const PLAYER: int = 1
const opponent: int = 0
const Ops: Dictionary = {}
var _initialized: bool = false
 

func get_operation(code: Bytecode.OpCodes): # return callable
	if not _initialized:
		_initialize()
	return Ops[code]
	
func _initialize() -> void:
	for key in Dictionary(Bytecode.OpCodes):
		Ops[Bytecode.OpCodes[key]] = Callable(self, StringName(key.capitalize().replace(" ", "_").to_lower().insert(0, "_"))) # int, Callable
	_initialized = true

func _if(effect: EffectState) -> void:
	var jump: int = effect.pop_back()
	var condition: int = effect.pop_back()
	if condition == 0: # 0 = false
		effect.jump(jump)

func _compare_and_push_result(effect: EffectState, comparator: Callable) -> void:
	var b = effect.pop_back()
	var a = effect.pop_back()
	effect.push(int(comparator.call(a, b)))

# Boolean
func _is_less_than(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a < b)
func _is_greater_than(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a > b)
func _is_equal(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a == b)
func _is_not_equal(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a != b)
func _and(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a and b)
func _or(effect: EffectState) -> void: _compare_and_push_result(effect, func(a, b): return a or b)

# Math
func _calculate(effect: EffectState, calculator: Callable) -> void:
	var b: int = effect.pop_back()
	var a: int = effect.pop_back()
	var result: int = calculator.call(a, b)
	effect.push(result)

func _add(effect: EffectState) -> void: _calculate(effect, func(a, b): return a + b)
func _subtract(effect: EffectState) -> void: _calculate(effect, func(a, b): return a - b)
func _multiply(effect: EffectState) -> void: _calculate(effect, func(a, b): return a * b)
func _divide(effect: EffectState) -> void: _calculate(effect, func(a, b): return a / b)
func _count_cards(effect: EffectState) -> void: effect.push(effect.cards.size())

# getters
func _get_player(effect: EffectState) -> ServerPlayer:
	var id: int = effect.pop_back()
	match id:
		PLAYER:
			return effect.controller
		opponent:
			return effect.opponent
		_: # default
			return effect.card.owner
			
func _literal(effect: EffectState) -> void: effect.push(effect.next())
func _get_owning_card(effect: EffectState) -> void: pass
func _get_owner(effect: EffectState) -> void: effect.push(OWNER)
func _get_controller(effect: EffectState) -> void: effect.push(PLAYER)
func _get_opponent(effect: EffectState) -> void: effect.push(opponent)

# getGlobalZones
func _get_decks(effect: EffectState) -> void: effect.cards += effect.controller.deck + effect.opponent.deck
func _get_hands(effect: EffectState) -> void: effect.cards += effect.controller.hand + effect.opponent.hand
func _get_graveyards(effect: EffectState) -> void: effect.cards += effect.controller.graveyard + effect.opponent.graveyard
func _get_units(effect: EffectState) -> void: effect.cards += effect.controller.units + effect.opponent.units
func _get_supports(effect: EffectState) -> void: effect.cards += effect.controller.supports + effect.opponent.supports

# getcontroller Zones
func _get_controller_deck(effect: EffectState) -> void: effect.cards += effect.controller.deck
func _get_controller_hand(effect: EffectState) -> void: effect.cards += effect.controller.hand
func _get_controller_graveyard(effect: EffectState) -> void: effect.cards += effect.controller.graveyard
func _get_controller_units(effect: EffectState) -> void: effect.cards += effect.controller.units
func _get_controller_supports(effect: EffectState) -> void: effect.cards += effect.controller.supports

# getopponent Zones
func _get_opponent_deck(effect: EffectState) -> void: effect.cards += effect.opponent.deck
func _get_opponent_hand(effect: EffectState) -> void: effect.cards += effect.opponent.hand
func _get_opponent_graveyard(effect: EffectState) -> void: effect.cards += effect.opponent.graveyard
func _get_opponent_units(effect: EffectState) -> void: effect.cards += effect.opponent.units
func _get_opponent_supports(effect: EffectState) -> void: effect.cards += effect.opponent.supports

# Actions
func _set_health(effect: EffectState) -> void:
	var player = _get_player(effect)
	var new_health: int = effect.pop_back()
	player.health = new_health
	
func _set_faction(effect: EffectState) -> void: pass
func _set_power(effect: EffectState) -> void: pass
func _destroy(effect: EffectState) -> void: pass
func _deal_damage(effect: EffectState) -> void: pass

func _draw(effect: EffectState) -> void:
	var player = _get_player(effect)
	var count = effect.pop_back()
	for i in count:
		var card = player.deck.pop_back()
		player.hand.append(card)
		effect.add_event(load("res://source/server/events/movement/draw.gd").new(card))
	#	effect.add_event(DrawEvent.new(card)) #// Cyclic Reference?
