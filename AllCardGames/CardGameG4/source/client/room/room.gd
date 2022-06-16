extends Window
class_name ClientRoom

# TODO: Add all the game-specific stuff once created
signal game_event


var user: User
var _messenger: ClientMessenger = ClientMessenger.new()
var _network: Multiplayer = Multiplayer.new()
var _command_queue: CommandQueue = CommandQueue.new()
var cards: Cards = Cards.new()
var effects: Effects = Effects.new()
@onready var player: Participant = $Player
@onready var rival: Participant = $Rival
@onready var table: Table = $Table
var cull_mask: int

func _init() -> void:
	
	_network.root_node = self
	custom_multiplayer = _network
	_messenger.custom_multiplayer = _network
	
	_network.connected_to_server.connect(_on_connected_to_server)
	_network.connection_failed.connect(_on_connection_failed)
	_network.server_disconnected.connect(_on_server_disconnected)
	
	_messenger.event_queued.connect(_on_command_queued)
	_messenger.updated.connect(_on_game_updated)
	
	cards.card_created.connect(_on_card_created)
	
	add_child(_messenger)
	add_child(cards)
	add_child(effects)
	cards.name = "Cards"
	effects.name = "Effects"
	
func _ready() -> void:
	$Camera3D.cull_mask = cull_mask
	$Table/TableMesh.layers = cull_mask
	$Table/PassPlayButton.layers = cull_mask
	
func _process(_delta: float) -> void:
	_network.update()
	
func _on_connected_to_server() -> void:
	print("Connected To Server")
	rpc_id(1, &"_register_player", ["Null Card", "Basic Unit", "Basic Support", "Null Card", "Basic Unit", "Basic Support", "Null Card", "Basic Unit", "Basic Support"])

func _on_connection_failed() -> void:
	print("Connection Failed")
	
func _on_server_disconnected() -> void:
	print("Disconnected from Server")
	
func _on_card_created(card: ClientCard) -> void:
	#card.card_pressed.connect(_input.on_card_pressed)
	card.get_node("Plane").layers = cull_mask
	game_event.emit(card) # very confusing, may require deciated classes
		
func _on_unit_deployed(unit: ClientCard) -> void:
	_network.messenger.rpc_id(1, &"deploy", unit.id)
	game_event.emit(unit)
	
func _on_card_set_facedown(facedown: ClientCard) -> void:
	_network.messenger.rpc_id(1, &"set_facedown", facedown.id)
	game_event.emit(facedown)
	
func _on_unit_attacked(attacker: ClientCard, defender: ClientCard) -> void:
	_network.messenger.rpc_id(1, &"attack_unit", attacker.id, defender.id)
	game_event.emit(attacker, defender)
	
func display() -> void:
	join()
	show()
	
func stop_displaying() -> void:
	leave()
	hide()
	
func _on_command_queued(commandId: Enums.CommandId, args) -> void:
	_command_queue.enqueue(commandId, args)
	
func _on_game_updated() -> void:
	_command_queue.update(self)
	
func join() -> void:
	_network.join("127.0.0.1", 5000)
	
func leave() -> void:
	_network.shutdown()
	
@rpc(authority)
func _on_match_found(n: String) -> void:
	print("Creating Room %s" % n)
	_messenger.name = n
	_messenger.rpc_id(1, &"_on_client_ready")

# Seems we require local method definitions
@rpc
func _register_player(decklist: Array) -> void:
	pass
