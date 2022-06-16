extends Resource
class_name ServerLibrary

@export var carddata: Array[Resource] = []
var _cards: Dictionary = {}
var _initialzied: bool = false

func _initialize() -> void:
	for card in carddata:
		_cards[card.setcode] = card
	_initialzied = true
	
func get_card(setcode: String) -> Card:
	if not _initialzied:
		_initialize()
	var data: CardData = _cards[setcode]
	var instance: Card = data.ServerScene.instantiate()
	instance.title = data.title
	instance.power = data.power
	instance.setcode = data.setcode
	instance.card_type = data.card_type
	instance.faction = data.faction
	return instance
