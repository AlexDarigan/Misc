extends Fixture

var test_player_getter1 = player_getter.bind(true, Bytecode.OpCodes.GetOwner, "The skills owner drew 3 cards")
var test_player_getter2 = player_getter.bind(true, Bytecode.OpCodes.GetController, "The skills controller drew 3 cards")
var test_player_getter3 = player_getter.bind(false, Bytecode.OpCodes.GetOpponent, "The skills opponent drew 3 cards")

func player_getter(is_player: bool, get_player: Bytecode.OpCodes, context: String) -> void:

	var support = common_play([Bytecode.OpCodes.Literal, 3, get_player, Bytecode.OpCodes.Draw])
	var player = _p1 if is_player else _p2
	var count = player.hand.size()
	_match.activate(_p1, support)
	_match.pass_play(_p2)
	_match.pass_play(_p1)

	asserts.is_true(player.hand.size() == count + 3, context)

var test_card_getter1 = card_getter.bind(Bytecode.OpCodes.GetControllerDeck, "deck", 0, 39, "Player drew a card for each card in their deck")
var test_card_getter2 = card_getter.bind(Bytecode.OpCodes.GetControllerHand, "hand", 0, 14, "Player drew a card for each card in their hand")
var test_card_getter3 = card_getter.bind(Bytecode.OpCodes.GetControllerUnits, "units", 2, 9, "Player drew a card for each card in their units")
var test_card_getter4 = card_getter.bind(Bytecode.OpCodes.GetControllerSupports, "supports", 0, 7, "Player drew a card for each card in their supports (including activated)")
var test_card_getter5 = card_getter.bind(Bytecode.OpCodes.GetControllerGraveyard, "graveyard", 4, 11, "Player drew a card for each card in their graveyard")

func card_getter(get_zone: Bytecode.OpCodes, zone_to_add_to: String, cards_to_add: int, expected: int, context: String) -> void:

	start_game(build_deck("Basic Support"))
	var support = common_play([Bytecode.OpCodes.GetController, get_zone, Bytecode.OpCodes.CountCards,
	Bytecode.OpCodes.GetController, Bytecode.OpCodes.Draw])
	for i in cards_to_add:
		_p1.get(zone_to_add_to).append(ServerCard.new(0, _p1))
	_match.activate(_p1, support)
	_match.pass_play(_p2)
	_match.pass_play(_p1)
	asserts.is_true(_p1.hand.size() == expected, context)
	
var test_comparison1 = comparison.bind(3, 3, Bytecode.OpCodes.IsEqual, "Opponent drew 5 cards because 3 is equal to 3")
var test_comparison2 = comparison.bind(5, 1, Bytecode.OpCodes.IsNotEqual, "Opponent drew 5 cards because 5 is not equal to 1")
var test_comparison3 = comparison.bind(9, 2, Bytecode.OpCodes.IsGreaterThan, "Opponent drew 5 cards because 9 is greater than 2")
var test_comparison4 = comparison.bind(2, 3, Bytecode.OpCodes.IsLessThan, "Opponent drew 5 cards because 2 is less than 3")
var test_comparison5 = comparison.bind(1, 1, Bytecode.OpCodes.And, "Opponent drew 5 cards because 1 AND 1 is true")
var test_comparison6 = comparison.bind(1, 0, Bytecode.OpCodes.Or, "Opponent drew 5 cards because 1 OR 0 is true")

func comparison(a: int, b: int, comparison: Bytecode.OpCodes, context: String) -> void:
	# failing, bad jumps?
	var jump = 4
	var support = common_play([Bytecode.OpCodes.Literal, a, Bytecode.OpCodes.Literal, b, comparison, 
	Bytecode.OpCodes.Literal, jump, Bytecode.OpCodes.If, Bytecode.OpCodes.Literal, 5, Bytecode.OpCodes.GetOpponent,
	Bytecode.OpCodes.Draw])
	var count = _p2.hand.size()
	_match.activate(_p1, support)
	_match.pass_play(_p2)
	_match.pass_play(_p1)
	asserts.is_true(_p2.hand.size() == count + 5, context)
	
var test_add = calculation.bind(Bytecode.OpCodes.Add, 500, 500, 1000, "Controllers health is set to the result of 500 + 500")
var test_subtract = calculation.bind(Bytecode.OpCodes.Subtract, 1000, 500, 500, "Controllers health is set to the result of 1000 - 500")
var test_multiply = calculation.bind(Bytecode.OpCodes.Multiply, 2, 1000, 2000, "Controllers health is set to the result of 2 x 1000")
var test_divide = calculation.bind(Bytecode.OpCodes.Divide, 1000, 2, 500, "Controllers health is set to the result of 1000 / 2")

func calculation(math: Bytecode.OpCodes, a: int, b: int, result: int, context: String) -> void:
	var support = common_play([Bytecode.OpCodes.Literal, a, Bytecode.OpCodes.Literal, b, math,
	Bytecode.OpCodes.GetController, Bytecode.OpCodes.SetHealth])

	var health: int = _p1.health
	_match.activate(_p1, support)
	_match.pass_play(_p2)
	_match.pass_play(_p1)
	asserts.is_true(_p1.health == result, context)
	
func common_play(ops) -> ServerCard:
	start_game(build_deck("Basic Support"))
	var card: ServerCard = _p1.hand[0]
	card.skill = build_skill(card, ops)
	_match.set_facedown(_p1, card)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	return card
