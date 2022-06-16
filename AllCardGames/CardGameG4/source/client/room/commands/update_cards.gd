extends Command

var _cards

func _init(cards) -> void:
	
	_cards = cards
	
func setup(board) -> void:
	for card in _cards:
		for key in card:
			board.cards.get_card(key).state = card[key]
