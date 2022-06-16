extends Command

var _decklist: Dictionary

func _init(decklist) -> void:
	_decklist = decklist

	
func setup(board) -> void:
	for key in _decklist:
		var card = board.cards.get_card(key, _decklist[key])
		board.player.deck.add(card)
		
	board.player.deck.update(Vector3(0, .03, 0))
