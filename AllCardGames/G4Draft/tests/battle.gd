extends Node

var P1: Player
var P2: Player
var game: Game

@export
var matchscene: PackedScene

func start_game(decklist: Array[String], decklist2: Array[String]):
	P1 = Player.new(1, decklist if not decklist.is_empty() else build_deck())
	P2 = Player.new(2, decklist2 if not decklist2.is_empty() else build_deck())
	game = matchscene.instantiate()
	game.setup(P1, P2)
	game.begin()
	
func build_deck(setcode: String = "0") -> Array[String]:
	var decklist: Array[String] = []
	for i in 40:
		decklist.append(setcode)
	return decklist


# Called when the node enters the scene tree for the first time.
func _ready():
	WinBattle.call_deferred()

func WinBattle():
	print("When an attack unit wins a Battle")
	P1 = Player.new(1, build_deck("1"))
	P2 = Player.new(2, build_deck("1"))
	game = matchscene.instantiate()
	game.setup(P1, P2)
	game.begin()
	var attacker: Card = P1.hand[0]
	var defender: Card = P2.hand[1]
	game.deploy(P1, attacker)
	game.end_turn(P1)
	game.deploy(P2, defender)
	game.end_turn(P2)
	attacker.power += 500
	var lifeCount: int = P2.health
	game.attack_unit(P1, attacker, defender)
	var difference: int = attacker.power - defender.power
	print("attacker is not ready: ", not attacker.is_ready)
	print("attackers power is greater than defenders: ", attacker.power > defender.power)
	print("the defending unit was sent to the graveyard: ", P2.graveyard.has(defender))
	print("the difference in power was subtracted from the defending player: ", P2.health == (lifeCount - difference))
	print("attacker is in card state none: ", attacker.state == Card.States.None)
#
