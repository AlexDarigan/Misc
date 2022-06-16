extends Node
class_name ServerRoom

var _match: ServerMatch

func _init(p1: ServerPlayer, p2: ServerPlayer) -> void:
	
	_match = ServerMatch.new(p1, p2)
	_match.game_event.connect(_on_game_event)
	_match.game_updated.connect(_on_game_updated)
	
func _get_sender() -> ServerPlayer:
	return _match.players[custom_multiplayer.get_remote_sender_id()]
	
func _get_card(id: int):
	return _match.cards[id]
	
@rpc(any_peer)
func _on_client_ready() -> void:
	_get_sender().ready = true
	for id in _match.players:
		if not _match.players[id].ready:
			return
	_match.begin(_match.players.values())
	
@rpc(any_peer)
func deploy(id: int) -> void:
	_match.deploy(_get_sender(), _get_card(id))

@rpc(any_peer)
func set_facedown(id: int) -> void:
	_match.set_facedown(_get_sender(), _get_card(id))

@rpc(any_peer)
func attack_unit(attackerId: int, defenderId: int) -> void:
	_match.attack_unit(_get_sender(), _get_card(attackerId), _get_card(defenderId))

@rpc(any_peer)
func attack_player(id: int) -> void:
	_match.attack_player(_get_sender(), _get_card(id))

@rpc(any_peer)
func activate(id: int) -> void:
	_match.activate(_get_sender(), _get_card(id))

@rpc(any_peer)
func pass_play() -> void:
	_match.pass_play(_get_sender())

@rpc(any_peer)
func end_turn() -> void:
	_match.end_turn(_get_sender())

func _on_game_event(event: GameEvent) -> void:
	event.queue_on_clients(_queue)
	
func _on_game_updated() -> void:
	for id in _match.players:
		var update_cards: Dictionary = {}
		for card in _match._cards:
			if card.controller.id != id:
				continue
			update_cards[card.id] = card.state
	
		# Note: Array unpacking could get messy
		_queue(id, Enums.CommandId.UpdateCards, [update_cards])
		_queue(id, Enums.CommandId.PlayerUpdate, [_match.players[id].state])
		_update(id)
	
func _queue(id: int, commandId: Enums.CommandId, args = []) -> void:
	rpc_id(id, &"queue", commandId, args)

func _update(id: int) -> void:
	rpc_id(id, &"update")
	
# Dummies
@rpc(authority)
func queue(commandId: Enums.CommandId, args: Array) -> void:
	pass
	
@rpc(authority)
func update() -> void:
	pass
