extends Fixture

func test_deploy() -> void:
	start_game(build_deck("Basic Unit"))
	var card: ServerCard = _p1.hand[0]
	asserts.is_true(card.card_type == Enums.CardTypes.Unit, "When it is a unit card")
	asserts.is_true(card.controller.state == Enums.States.IdleTurnPlayer, "And its controller is idle turn player")
	asserts.is_true(card.controller.hand.has(card), "And it is in their controllers hand")
	asserts.is_true(card.controller.units.size() < 5, "And its controller's unit zones is not full")
	asserts.is_true(card.state == Enums.CardStates.Deploy, "Then it can be deployed")
	
func test_setfacedown() -> void:
	start_game(build_deck("Basic Support"))
	var card: ServerCard = _p1.hand[0]
	asserts.is_true(card.card_type == Enums.CardTypes.Support, "When it is a support card")
	asserts.is_true(card.controller.state == Enums.States.IdleTurnPlayer, "And its controller is idle turn player")
	asserts.is_true(card.controller.hand.has(card), "And it is in their controllers hand")
	asserts.is_true(card.controller.supports.size() < 5, "And its controller's support zones is not full")
	asserts.is_true(card.state == Enums.CardStates.SetFaceDown, "Then it can be set face-down")
	
func test_activation() -> void:
	start_game(build_deck("Basic Support"))
	var card: ServerCard = _p1.hand.pop_back()
	_match.set_facedown(_p1, card)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	asserts.is_true(card.card_type == Enums.CardTypes.Support, "When it is a support card")
	asserts.is_true(card.controller.state == Enums.States.IdleTurnPlayer, "And its controller is idle turn player")
	asserts.is_true(card.controller.supports.has(card), "And it is in their controllers supports")
	asserts.is_true(card.is_ready, "And it is ready")
	asserts.is_true(card.state == Enums.CardStates.Activate, "Then it can be set face-down")
	
func test_attack_unit() -> void:
	start_game(build_deck("Basic Unit"), build_deck("Basic Unit"))
	var card: ServerCard = _p1.hand[0]
	var defender: ServerCard = _p2.hand[0]
	_match.deploy(_p1, card)
	_match.end_turn(_p1)
	_match.deploy(_p2, defender)
	_match.end_turn(_p2)
	asserts.is_true(card.card_type == Enums.CardTypes.Unit, "When it is a unit card")
	asserts.is_true(card.controller.state == Enums.States.IdleTurnPlayer, "And its controller is idle turn player")
	asserts.is_true(card.controller.units.has(card), "And it is in their controllers units")
	asserts.is_true(card.is_ready, "And it is ready")
	asserts.is_true(not _p2.units.is_empty(), "And its controllers opponents unit zone is not empty")
	asserts.is_true(card.state == Enums.CardStates.AttackUnit, "Then it can attack target unit")
	
func test_attack_directly() -> void:
	start_game(build_deck("Basic Unit"))
	var card: ServerCard = _p1.hand.pop_back()
	_match.deploy(_p1, card)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	asserts.is_true(card.card_type == Enums.CardTypes.Unit, "When it is a unit card")
	asserts.is_true(card.controller.state == Enums.States.IdleTurnPlayer, "And its controller is idle turn player")
	asserts.is_true(card.controller.units.has(card), "And it is in their controllers units")
	asserts.is_true(card.is_ready, "And it is ready")
	asserts.is_true(_p2.units.is_empty(), "And its controllers opponents unit zone is not empty")
	asserts.is_true(card.state == Enums.CardStates.AttackPlayer, "Then it can attack target player")
