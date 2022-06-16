extends Node
class_name Cards

const CARD: PackedScene = preload("res://source/client/room/card/Card.tscn")
signal card_created
var _cards: Dictionary = {} # int (id) / card
	
func get_card(id: int, setcode: String = "Null Card") -> ClientCard:
	if not _cards.has(id):
		_create_card(id, setcode)
	return _cards[id]
	
func _create_card(id: int, setcode: String) -> void:
	var card: ClientCard = CARD.instantiate()
	var info: RefCounted = ClientLibrary.get_card(setcode)
	add_child(card)
	card.name = "[%s %s]" % [id, setcode]
	card.id = id
	card.art = info.art
	_cards[card.id] = card
	remove_child(card)
	card_created.emit(card)
	
