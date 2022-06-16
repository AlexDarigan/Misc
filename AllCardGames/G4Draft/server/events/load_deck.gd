extends Event
class_name LoadDeck

var player: Player
var decklist: Dictionary

func _init(_player: Player, _decklist: Dictionary) -> void:
	player = _player
	decklist = _decklist # int, string (id, setcode)
