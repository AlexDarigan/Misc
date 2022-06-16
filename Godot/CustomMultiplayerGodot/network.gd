extends Node

var _peer: NetworkedMultiplayerENet

func _init() -> void:
	# We create a unique copy of the MultiplayerAPI instead of the singleton..
	# ..instance in the scene tree
	custom_multiplayer = MultiplayerAPI.new()
	
	# We set the root node of the custom_multiplayer to ourselves..
	# ..so as far as rpc's are concerned, our path is "." (as if we were the..
	# ..true node of the tree)
	custom_multiplayer.root_node = self
	_peer = NetworkedMultiplayerENet.new()
	
func _process(delta: float) -> void:
	# Since we're using the custom multiplayer API instead of the default..
	# ..singleton, we need to poll it ourselves in _process to make it work
	if custom_multiplayer.has_network_peer():
		custom_multiplayer.poll()
		
# NOTE
# We set the custom multiplayer for *this* node but not for our children nodes..
# ..who will default to the scene tree. If you are going to have RPCs..
# ..all over your code you need to make sure the nodes share the same ..
# ..multiplayer node.
# HOWEVER..
# ..my advice is to create a dedicated Network Interface script as a focal..
# ..point to send and receive RPCs to delegate between the different objects
