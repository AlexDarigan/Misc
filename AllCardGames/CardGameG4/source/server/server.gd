extends Window

var _network: Multiplayer = Multiplayer.new()
var _match_maker: MatchMaker = MatchMaker.new()

func _init() -> void:
	_match_maker.match_made.connect(_on_match_made)
	_network.peer_connected.connect(_on_network_peer_connected)
	_network.peer_disconnected.connect(_on_network_peer_disconnected)
	_network.root_node = self
	custom_multiplayer = _network
	
func _ready() -> void:
	_network.host()
	
func _process(_delta: float) -> void:
	_network.update()
	_match_maker.update()
	
func _exit_tree() -> void:
	_network.shutdown()
	
func _on_network_peer_connected(id: int) -> void:
	print("%s has connected" % id)
	
func _on_network_peer_disconnected(id: int) -> void:
	print("%s has disconnected" % id)
	
func _on_match_made(p1: ServerPlayer, p2: ServerPlayer, room: ServerRoom) -> void:
	room.custom_multiplayer = _network
	add_child(room)
	rpc_id(p1.id, &"_on_match_found", room.name)
	rpc_id(p2.id, &"_on_match_found", room.name)
	
@rpc(any_peer)
func _register_player(decklist: Array) -> void:
	print("%s has registered" % _network.get_remote_sender_id())
	_match_maker.queue_player(ServerPlayer.new(_network.get_remote_sender_id(), decklist))
	
# Dummy Methods
@rpc(authority)
func _on_match_found(n: String) -> void:
	pass
