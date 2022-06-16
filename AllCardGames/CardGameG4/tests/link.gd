extends Fixture

func test_activation() -> void:
	start_game(build_deck("Basic Support"))
	var support = _p1.hand[0]
	_match.set_facedown(_p1, support)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	var hand_count = _p1.hand.size()
	var deck_count = _p1.deck.size()

	_match.activate(_p1, support)
	_match.pass_play(_p2)
	_match.pass_play(_p1)

	asserts.is_true(_p1.hand.size() == hand_count + 2, "Player added 2 cards to their hand")
	asserts.is_true(_p1.deck.size() == deck_count - 2, "Player removed 2 cards from their deck")
	asserts.is_true(_p1.graveyard.has(support), "Support was moved to graveyard")
