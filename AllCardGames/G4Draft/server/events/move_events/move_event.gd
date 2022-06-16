extends Event
class_name MoveEvent

var card: Card
var controller: Player

func _init(_card: Card) -> void:
	controller = _card.controller
	card = _card
	
