extends Event
class_name Activation

var player: Player
var activated: Card

func _init(_player: Player, _card: Card) -> void:
	player = _player
	activated = _card
