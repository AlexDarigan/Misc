extends Command

var _card_id: int

func _init(card_id: int) -> void:
	_card_id = card_id
	
func setup(board) -> void:
	var card = board.cards.get_card(_card_id)
	board.player.deck.remove(card)
	board.player.hand.add(card)
	board.player.hand.shift(Vector3(-ClientCard.WIDTH / 2, 0, 0))
	board.player.hand.update2(Vector3(ClientCard.WIDTH, 0, 0), board)
