extends RefCounted
class_name ServerPlayer

var id: int = 0:
	set(value): id = value if id == 0 else id

var decklist: Array = []
var deck: Array = []
var graveyard: Array = []
var hand: Array = []
var supports: Array = []
var units: Array = []
var reason_player_was_disqualified: Enums.Illegal = Enums.Illegal.NotDisqualified

# Old Note: TODO: Remove this when old tests are removed
var disqualified: bool = false
var health: int = 8000
var opponent: ServerPlayer
var ready: bool = false
var state: Enums.States = Enums.States.Passive

func _init(_id: int, _decklist: Array) -> void:
	id = _id
	decklist = _decklist
