extends Test
class_name Fixture

var _p1: ServerPlayer
var _p2: ServerPlayer
var _match: ServerMatch

func test_auto_pass() -> void:
	asserts.is_true(true, "auto pass fixture")

func start_game(decklist1: Array = [], decklist2: Array = []) -> void:
	_p1 = ServerPlayer.new(1, build_deck() if decklist1.is_empty() else decklist1)
	_p2 = ServerPlayer.new(2, build_deck() if decklist2.is_empty() else decklist2)
	_match = ServerMatch.new(_p1, _p2)
	_match.begin([_p1, _p2])

func build_deck(setcode: String = "Null Card") -> Array:
	var decklist: Array = []
	for i in 40:
		decklist.append(setcode)
	return decklist
	
func build_skill(support: ServerCard, codes: Array) -> CardEffect:
	return CardEffect.new(support, [], codes, "")
	
class MockRoom extends Node:
	
	func declare(commandId: Enums.CommandId, args: Array) -> void:
		rpc_id(1, str(commandId) as StringName, args)
