extends Event
class_name Resolve

var player: Player
var card: Card

func _init(_player: Player, _card: Card = null):
	player = _player
	card = _card

