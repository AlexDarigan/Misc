extends Node
class_name Player

enum States {
	IdleTurnPlayer,
	Passing,
	Passive,
	Acting,
	Active
}

var id: int
var health: int = 8000
var state: States = States.Passive
var decklist: Array[String] = []
var deck: Array[Card] = []
var hand: Array[Card] = [] 
var units: Array[Card] = []
var supports: Array[Card] = []
var graveyard: Array[Card] = []
var reason_player_was_disqualifed: Judge.Illegal = Judge.Illegal.NotDisqualified
var opponent: Player
var is_ready: bool = false

func _init(_id: int, _decklist: Array[String]) -> void:
	id = _id
	decklist = _decklist
