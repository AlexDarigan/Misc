extends Node
class_name Game
signal game_updated
signal game_event

@export
var library: Resource

var events: Array[Event] = []
var cards: Dictionary
var players: Dictionary
var link: Node
var turn_player: Player
var game_over: bool = false
var next_card_id = 1
#
func setup(p1: Player, p2: Player) -> void:
	game_event.connect(func(ev): events.append(ev))
	players[p1.id] = p1
	players[p2.id] = p2
	game_over = false
	p1.opponent = p2
	p2.opponent = p1
#
func disqualified(condition: bool, player: Player, reason: Judge.Illegal) -> bool:
	if game_over:
		return true
	if condition:
		print("player %s disqualified for %s" % [player.id, reason])
		player.reason_player_was_disqualifed = reason
	return condition
#
func begin() -> void:
	for player in players.values():
		for setcode in player.decklist: # setcode or name
			var card: Card = library.get_card(setcode)
			card.id = next_card_id
			next_card_id += 1
			card.possessor = player
			card.controller = player
			player.deck.append(card)
			cards[card.id] = card
		var decklist: Dictionary = {}
		for card in player.deck:
			decklist[card.id] = card.setcode
		game_event.emit(LoadDeck.new(player, decklist))
	for player in players.values():
		for i in 7:
			var card = player.deck.pop_back()
			player.hand.append(card)
			game_event.emit(Draw.new(card))

	turn_player = players.values()[0]
	turn_player.state = turn_player.States.IdleTurnPlayer

	update()

func deploy(player: Player, unit: Card) -> void:
	if disqualified(unit.state != unit.States.Deploy, player, Judge.Illegal.Deploy):
		print("disqualified")
		return

	player.hand.erase(unit)
	player.units.append(unit)
	unit.zone = player.units
	game_event.emit(Deploy.new(unit))
	print("player %s deployed unit %s" % [player.id, unit.id])

	update()
#
func attack_unit(player: Player, attacker: Card, defender: Card) -> void:
	if disqualified(attacker.state != attacker.States.AttackUnit, player, Judge.Illegal.AttackUnit):
		print("disqualified: ", attacker.state)
		return

	game_event.emit(AttackUnit.new(attacker, defender))
	print(attacker.id, " attacked ", defender.id)
	# TODO: Make sure this isn't a duplicate list (@past me: what?!)
	var damage_calculation = func dc(winner: Card, loser: Card, ge: Signal):
		loser.controller.health -= winner.power - loser.power
		ge.emit(SetHealth.new(loser.controller))

		loser.controller.units.erase(loser)
		loser.possessor.graveyard.append(loser)

		ge.emit(SentToGraveyard.new(loser))
		if loser.controller.health <= 0:
			game_over = true
			# emit game over event
			ge.emit(GameOver.new(loser.controller))
		return
	var _x = 0# hck to fix ternary issue
	if attacker.power > defender.power:
		damage_calculation.call(attacker, defender, game_event)
	elif defender.Power > attacker.power:
		damage_calculation.call(defender, attacker, game_event)
	attacker.is_ready = false;

	update()

func attack_player(player: Player, attacker: Card) -> void:
	if disqualified(attacker.state != attacker.States.AttackPlayer, player, Judge.Illegal.AttackPlayer):
		return

	player.opponent.health -= attacker.power
	game_event.emit(AttackPlayer.new(attacker))
	game_event.emit(SetHealth.new(player.opponent))

	if player.opponent.health <= 0:
		player.state = player.States.Winner
		player.Opponent.State = player.States.Loser
		game_over = true
		game_event.emit(GameOver.new(player.opponent))

	attacker.is_ready = false

	update()
#
func set_facedown(player: Player, support: Card) -> void:
	if disqualified(support.state != support.States.SetFaceDown, player, Judge.Illegal.SetFaceDown):
		return
	player.hand.erase(support)
	player.supports.append(support)
	support.zone = player.supports
	game_event.emit(SetFaceDown.new(support))
	update()

func activate(player: Player, support: Card) -> void:
	if disqualified(support.state != support.States.Activate, player, Judge.Illegal.Activation):
		return

	# TODO: Implement SkillState
	var skillstate = support.Activate()
	game_event.emit(Activation.new(support.controller, support))

	player.supports.erase(support)
	link.append(skillstate)
	player.state = player.States.Acting
	player.opponent.state = player.States.Active
	
	update()

func pass_play(player: Player) -> void:
	if disqualified(player.state != player.States.Active, player, Judge.Illegal.PassPlay):
		return
	match player.opponent.state:
		Player.States.Acting:
			player.state = Player.States.Passing
			player.opponent.state = Player.States.Active
		Player.States.Passing:
			while link.is_resolving():
				# emit new resolve event
				game_event.emit(Resolve.new(turn_player))
				for args in link.resolve():
					game_event.emit(args)
			turn_player.state = Player.States.IdleTurnPlayer
			turn_player.opponent.state = Player.States.Passive
		_:
			pass

	update()
#
func end_turn(player: Player) -> void:
	if disqualified(player.state != Player.States.IdleTurnPlayer, player, Judge.Illegal.EndTurn):
		return

	player.state = Player.States.Passive
	player.state = Player.States.IdleTurnPlayer

	game_event.emit(EndTurn.new(player))

	turn_player = turn_player.opponent
	turn_player.state = Player.States.IdleTurnPlayer
	turn_player.opponent.state = Player.States.Passive

	if not player.opponent.deck.is_empty():
		var card = player.opponent.deck.pop_back()
		player.hand.append(card)
		game_event.emit(Draw.new(card))
	else:
		player.state = Player.States.Winner
		player.opponent.state = Player.States.Loser
		game_over = true
		game_event.emit(GameOver.new(player.opponent))
		# emit new game over event

	for card in player.units:
		card.is_ready = true
	for card in player.supports:
		card.is_ready = true

	update()
#
func update():
	for card in cards.values():
		card.update()
	game_updated.emit()
