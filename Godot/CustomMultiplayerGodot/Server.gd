extends "network.gd"

func _ready() -> void:
	custom_multiplayer.connect("network_peer_connected", self, "_on_network_peer_connected")
	var result: int = _peer.create_server(5005)
	if result == OK:
		# Set our custom multiplayer's peer to our peer
		custom_multiplayer.network_peer = _peer
		
func _on_network_peer_connected(id: int) -> void:
	print("Client %s has connected to the Server" % id as String)
	rpc_id(id, "server_says", "Hello Client")
	
master func client_replies(reply: String) -> void:
	print(reply)
