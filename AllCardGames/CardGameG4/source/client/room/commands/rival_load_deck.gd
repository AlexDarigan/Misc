extends Command

func setup(board) -> void:
	
	for id in range(-41, 0, 1):
		var card = board.cards.get_card(id, "Null Card")
		board.rival.deck.add(card)
		
	board.rival.deck.update(Vector3(0, ClientCard.THICKNESS, 0))
