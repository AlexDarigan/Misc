extends "network.gd"

func _ready() -> void:
	custom_multiplayer.connect("connected_to_server", self, "_on_connected_to_server")
	var result: int = _peer.create_client("127.0.0.1", 5005)
	if result == OK:
		custom_multiplayer.network_peer = _peer
	
func _on_connected_to_server() -> void:
	print("Connected to server")
	
puppet func server_says(msg: String) -> void:
	print(msg)
	# Server's ID is by default 1
	rpc_id(1, "client_replies", "Hello Server")
