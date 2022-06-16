extends Fixture

func test_decked_out() -> void:
	describe("Player 2 lost due to deck out")
	start_game()
	for i in 34:
		_match.end_turn(_p1)
		_match.end_turn(_p2)
	
	asserts.is_true(_match.game_over, "game is over")
	asserts.is_true(_p1.state == Enums.States.Winner, "Player 1 won")
	asserts.is_true(_p2.state == Enums.States.Loser, "Player 2 lost")
	asserts.is_true(_p2.deck.is_empty(), "Player 2 has no cards left in their deck")
	
func test_health_ran_out() -> void:
	describe("Player 2 lost due to health reaching 0")
	start_game(build_deck("Basic Unit"))
	var unit: ServerCard = _p1.hand.pop_back()
	_match.deploy(_p1, unit)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	var health: int = _p2.health
	unit.power = health
	_match.attack_player(_p1, unit)
	
	asserts.is_true(_match.game_over, "game is over")
	asserts.is_true(_p1.state == Enums.States.Winner, "Player 1 won")
	asserts.is_true(_p2.state == Enums.States.Loser, "Player 2 lost")
	asserts.is_true(_p2.health == 0, "Player 2's health is 0")

