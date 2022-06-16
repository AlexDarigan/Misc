extends Node
class_name Fixture

var P1: Player
var P2: Player
var game: Match

func start_game(decklist: Array[String], decklist2: Array[String]):
	P1 = Player.new(1, decklist if not decklist.is_empty() else build_deck())
	P2 = Player.new(2, decklist2 if not decklist2.is_empty() else build_deck())
	game = load("res://server/match.tscn").instantiate()
	game.setup(P1, P2)
	game.begin([P1, P2])
	
func build_deck(setcode: String = "0") -> Array[String]:
	var decklist: Array[String] = []
	for i in 40:
		decklist.append(setcode)
	return decklist
