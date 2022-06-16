extends MultiplayerAPI
class_name Multiplayer

signal server_connected

func host(port: int = 5000) -> void:
	print("Server Ready!")
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var err: int = peer.create_server(port)
	if err != OK:
		push_error(error_string(err))
		return
	multiplayer_peer = peer
	if multiplayer_peer.get_connection_status() == MultiplayerPeer.CONNECTION_CONNECTED:
		print("Server is Live")
		server_connected.emit()
	
func join(address: String, port: int) -> void:
	print("Joining Server")
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var err: int = peer.create_client(address, port)
	if err != OK:
		push_error(error_string(err))
	multiplayer_peer = peer 
	
func update() -> void:
	if has_multiplayer_peer():
		poll()
	
func shutdown(u_sec_wait: int = 100) -> void:
	if multiplayer_peer and multiplayer_peer.get_connection_status() == MultiplayerPeer.CONNECTION_CONNECTED:
			multiplayer_peer.close_connection(u_sec_wait)
