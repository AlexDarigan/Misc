extends Fixture

func title() -> String:
	return "Player Actions"
	
# There is no draw action
#func test_draw() -> void:
#	start_game(build_deck("Basic Unit"))
#	var deck_count: int = _p1.deck.size()
#	var hand_count: int = _p1.hand.size()
#	_match.draw(_p1)
#	asserts.is_true(_p1.hand.size() == hand_count + 1, "The player's hand count increased by 1")
#	asserts.is_true(_p2.deck.size() == deck_count - 1, "The player's deck count decreased by 1")
	
func test_deploy() -> void:
	start_game(build_deck("Basic Unit"))
	var hand_count: int = _p1.hand.size()
	var unit_count: int = _p1.units.size()
	_match.deploy(_p1, _p1.hand[0])
	asserts.is_true(_p1.units.size() == unit_count + 1, "The player's unit count increased by 1")
	asserts.is_true(_p1.hand.size() == hand_count - 1, "The player's hand count decreased by 1")

func test_setfacedown() -> void:
	start_game(build_deck("Basic Support"))
	var hand_count: int = _p1.hand.size()
	var support_count: int = _p1.supports.size()
	_match.set_facedown(_p1, _p1.hand[0])
	asserts.is_true(_p1.supports.size() == support_count + 1, "The player's support count increased by 1")
	asserts.is_true(_p1.hand.size() == hand_count - 1, "The player's hand count decreased by 1")
