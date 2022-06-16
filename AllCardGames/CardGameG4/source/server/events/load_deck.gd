extends GameEvent
class_name LoadDeckEvent

var _player: ServerPlayer
var _deck: Dictionary # Maybe Array[Key, Pair]?
	
func _init(player: ServerPlayer, deck: Dictionary) -> void:
	_player = player
	_deck = deck
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_player.id, Enums.CommandId.PlayerLoadDeck, _deck)
	queue.call(_player.opponent.id, Enums.CommandId.RivalLoadDeck)
