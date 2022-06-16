extends Command

func setup(board) -> void:
	
	var card = board.rival.deck.get_child(board.rival.deck.get_child_count() - 1)
	board.rival.deck.remove(card)
	board.rival.hand.add(card)
	board.rival.hand.shift(Vector3(ClientCard.WIDTH / 2, 0, 0))
	board.rival.hand.update2(Vector3(-ClientCard.WIDTH, 0, 0), board)
