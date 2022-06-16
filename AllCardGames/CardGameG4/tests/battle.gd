extends Fixture

func test_win_battle() -> void:
	describe("When an attacking Unit wins a battle")
	start_game(build_deck("Basic Unit"), build_deck("Basic Unit"))
	var attacker: ServerCard = _p1.hand[0]
	var defender: ServerCard = _p2.hand[0]
	_match.deploy(_p1, attacker)
	_match.end_turn(_p1)
	_match.deploy(_p2, defender)
	_match.end_turn(_p2)
	
	attacker.power += 500
	var life_count: int = _p2.health
	_match.attack_unit(_p1, attacker, defender)
	var difference: int = attacker.power - defender.power
	asserts.is_true(not attacker.is_ready, "attacker is exhasuted")
	asserts.is_true(attacker.power > defender.power, "The attacker's power is greater than the defenderrs power")
	asserts.is_true(_p2.graveyard.has(defender), "The defending unit was sent to the graveyard")
	asserts.is_true(life_count - difference == _p2.health, "The difference in power was subtracted from the defender")
	asserts.is_true(attacker.state == Enums.CardStates.None, "Attacker is in card state None")
	
func test_lose_battle() -> void:
	describe("When an attacking Unit loses a battle")
	start_game(build_deck("Basic Unit"), build_deck("Basic Unit"))
	var attacker: ServerCard = _p1.hand[0]
	var defender: ServerCard = _p2.hand[0]
	_match.deploy(_p1, attacker)
	_match.end_turn(_p1)
	_match.deploy(_p2, defender)
	_match.end_turn(_p2)

	defender.power += 500
	var life_count: int = _p1.health
	_match.attack_unit(_p1, attacker, defender)
	var difference: int = defender.power - attacker.power
	asserts.is_true(defender.power > attacker.power, "The defenders's power is greater than the attackers power")
	asserts.is_true(_p1.graveyard.has(attacker), "The attacking unit was sent to the graveyard")
	asserts.is_true(life_count - difference == _p1.health, "The difference in power was subtracted from the attacker")
	asserts.is_true(attacker.state == Enums.CardStates.None, "Attacker is in card state None")

func test_tie_battle() -> void:
	describe("When a battle is tied")
	start_game(build_deck("Basic Unit"), build_deck("Basic Unit"))
	var attacker: ServerCard = _p1.hand[0]
	var defender: ServerCard = _p2.hand[0]
	_match.deploy(_p1, attacker)
	_match.end_turn(_p1)
	_match.deploy(_p2, defender)
	_match.end_turn(_p2)

	var p1_health: int = _p1.health
	var p2_health: int = _p2.health
	_match.attack_unit(_p1, attacker, defender)

	asserts.is_true(_p1.health == p1_health, "Player 1 did not lose health")
	asserts.is_true(_p2.health == p2_health, "Player 2 did not lose health")
	asserts.is_true(not attacker.is_ready, "Attacker is exhausted")
	asserts.is_true(_p1.units.has(attacker), "Attacker is still on the field")
	asserts.is_true(_p2.units.has(defender), "Defender is still on the field")
	asserts.is_true(attacker.state == Enums.CardStates.None, "Attacker is in card state None")

func test_direct_attack() -> void:
	describe("When a unit attacks directly")
	start_game(build_deck("Basic Unit"), build_deck("Basic Unit"))
	var attacker: ServerCard = _p1.hand[0]
	_match.deploy(_p1, attacker)
	_match.end_turn(_p1)
	_match.end_turn(_p2)
	var health: int = _p2.health
	_match.attack_player(_p1, attacker)

	asserts.is_true(_p2.health == health - attacker.power, "Defending player lost health equal to attacker's power")
	asserts.is_true(not attacker.is_ready, "attacker is exhausted")
	asserts.is_true(attacker.state == Enums.CardStates.None, "Attacker is in card state none")

