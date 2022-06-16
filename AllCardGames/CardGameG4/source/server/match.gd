extends RefCounted
class_name ServerMatch

signal game_event
signal game_updated

var _cards: Array = []
var players: Dictionary
var _history: Array = []
var _link: Array = []
var _turn_player: ServerPlayer
var game_over: bool = false

func _init(p1: ServerPlayer, p2: ServerPlayer) -> void:
	players = { p1.id: p1, p2.id: p2 }
	p1.opponent = p2
	p2.opponent = p1
	
	game_event.connect(func(event): _history.append(event))
	
func disqualified(condition: bool, player: ServerPlayer, reason: Enums.Illegal) -> bool:
	if game_over:
		return true
	player.reason_player_was_disqualified = reason
	return condition
	
func begin(players: Array, loadDeck: Callable = Callable()) -> void:
	
	for player in players:
		var deckdict: Dictionary = {}
		for setcode in player.decklist:
			var card_info: ServerLibrary.CardInfo = ServerLibrary.get_card(setcode)
			var skill_info: ServerLibrary.SkillInfo = card_info.skill
			var card = ServerCard.new(_cards.size(), player)
			card.setcode = setcode
			card.title = card_info.title
			card.card_type = card_info.card_type
			card.faction = card_info.faction
			card.power = card_info.power
			card.skill = CardEffect.new(card, skill_info.triggers, skill_info.op_codes, skill_info.description)
			_cards.append(card)
			player.deck.append(card)
			deckdict[card.id] = card.setcode
		game_event.emit(LoadDeckEvent.new(player, deckdict))
		
	for player in players:
		for i in 7:
			var card: ServerCard = player.deck.pop_back()
			player.hand.append(card)
			game_event.emit(DrawEvent.new(card))
			
	_turn_player = players[0]
	_turn_player.state = Enums.States.IdleTurnPlayer
	
	update()
	
func deploy(player: ServerPlayer, unit: ServerCard) -> void:
	
	if disqualified(unit.state != Enums.CardStates.Deploy, player, Enums.Illegal.Deploy):
		return
	player.hand.erase(unit)
	player.units.append(unit)
	unit.zone = player.units
	game_event.emit(DeployEvent.new(unit))
	update()
	
func attack_unit(player: ServerPlayer, attacker: ServerCard, defender: ServerCard) -> void:
	
	if disqualified(attacker.state != Enums.CardStates.AttackUnit, player, Enums.Illegal.AttackUnit):
		return
		
	game_event.emit(AttackUnitEvent.new(attacker, defender))

	# Seems we can't capture signals in anonymous lambdas
	var damage_calulation = func(winner: ServerCard, loser: ServerCard, event: Signal):
		loser.controller.health -= winner.power - loser.power
		event.emit(SetHealthEvent.new(loser.controller))

		loser.controller.units.erase(loser)
		loser.owner.graveyard.append(loser)
		event.emit(SentToGraveyardEvent.new(loser))
#
		if loser.controller.health <= 0:
			game_over = true
			event.emit(GameOverEvent.new(loser.controller))
		
	pass

	if attacker.power > defender.power:
		damage_calulation.call(attacker, defender, game_event)
	elif defender.power > attacker.power:
		damage_calulation.call(defender, attacker, game_event)

	attacker.is_ready = false
	
	update()
	
func attack_player(player: ServerPlayer, attacker: ServerCard) -> void:
	
	if disqualified(attacker.state != Enums.CardStates.AttackPlayer, player, Enums.Illegal.AttackPlayer):
		return
	player.opponent.health -= attacker.power
	
	game_event.emit(AttackPlayerEvent.new(attacker))
	game_event.emit(SetHealthEvent.new(player.opponent))
	
	if player.opponent.health <= 0:
		player.state = Enums.States.Winner
		player.opponent.state = Enums.States.Loser
		game_over = true
		game_event.emit(GameOverEvent.new(player.opponent))
		
	attacker.is_ready = false
	
	update()
	
func set_facedown(player: ServerPlayer, support: ServerCard) -> void:
	
	if disqualified(support.state != Enums.CardStates.SetFaceDown, player, Enums.Illegal.SetFaceDown):
		return
		
	player.hand.erase(support)
	player.supports.append(support)
	support.zone = player.supports
	game_event.emit(SetFacedownEvent.new(support))
	
	update()
	
func activate(player: ServerPlayer, support: ServerCard) -> void:
	
	if disqualified(support.state != Enums.CardStates.Activate, player, Enums.Illegal.Activation):
		return
		
	var skill_state = support.activate()
	game_event.emit(ActivationEvent.new(player, support))
	# Link is a Zone (what?)
	player.supports.erase(support)
	_link.append(skill_state)
	player.state = Enums.States.Acting
	player.opponent.state = Enums.States.Active
	
	update()
	
func pass_play(player: ServerPlayer) -> void:
	
	if disqualified(player.state != Enums.States.Active, player, Enums.Illegal.PassPlay):
		return
	
	match player.opponent.state:
		Enums.States.Acting:
			player.state = Enums.States.Passing
			player.opponent.state = Enums.States.Active
		Enums.States.Passing:
			
			# Might be expensive to make a lambda on demand this often?
			# Maybe lambdas could exist as a generator method?

				
				
	#		// TODO:
	#        // Apply Triggers - When, Where, and how to respond? Maybe Async?
	#        // Targeting (Set valid targets beforehand, server only needs to check validity)
	#        // Resolve Events (Push Loop Up?)
	#        // while(link.resolving) resolve = link.next()
	#        // record
	#        // queue
	#
	#        // Some skills affect game state visually
	#        // or rather some OPERATIONS do that so we need a way to return those operations back to the game state
	#        // ...we could have the Resolve/Execute() function pass the result of the final method
			while not _link.is_empty():
				game_event.emit(ResolveEvent.new(_turn_player))
				
				var state: EffectState = _link.pop_back() # removing pre-execute may cause bug
				var events: Array = state.execute()
				state.controller.supports.erase(state.card)
				state.controller.graveyard.append(state.card)
				
				for event in events:
					game_event.emit(event)
			
			_turn_player.state = Enums.States.IdleTurnPlayer
			_turn_player.opponent.state = Enums.States.Passive
		_:
			pass
	
func end_turn(player: ServerPlayer) -> void:
	
	if disqualified(player.state != Enums.States.IdleTurnPlayer, player, Enums.Illegal.EndTurn):
		return
		
	player.state = Enums.States.Passive
	player.opponent.state = Enums.States.IdleTurnPlayer
	
	game_event.emit(EndTurnEvent.new(player))
	
	_turn_player = _turn_player.opponent
	_turn_player.state = Enums.States.IdleTurnPlayer
	_turn_player.opponent.state = Enums.States.Passive
	
	if not player.opponent.deck.is_empty():
		var card: ServerCard = player.opponent.deck.pop_back()
		player.opponent.hand.append(card)
		game_event.emit(DrawEvent.new(card))
	else:
		player.state = Enums.States.Winner
		player.opponent.state = Enums.States.Loser
		game_over = true
		game_event.emit(GameOverEvent.new(player.opponent))
		
	for card in player.units:
		card.is_ready = true
	for card in player.supports:
		card.is_ready = true
		
	update()
	
func update() -> void:
	for card in _cards:
		card.update()
	game_updated.emit()
