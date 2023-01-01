@tool
extends Node

const PORT: int = 5000
const ADDRESS: String = "127.0.0.1"
var server: TCPServer = TCPServer.new()
var socket: StreamPeerTCP
var json: JSON = JSON.new()
signal queued
signal started
var len: int = 0
var message_data: PackedByteArray = []

func _ready() -> void:
	if not Engine.is_editor_hint():
		host()
		
func _process(delta):
	if server.is_connection_available():
		socket = server.take_connection()
	if not socket:
		return
	socket.poll()
	dispatch(get_message())

func get_message() -> Variant:
	var message: Dictionary = {method = ""}
	if len == 0 and socket.get_available_bytes() >= 64:
		len = socket.get_64()
		message_data.clear()
	elif len > 0 and socket.get_available_bytes() >= len:
		var data: Array = socket.get_data(len)
		message_data.append_array(data[1])
		len = 0
		message = JSON.parse_string(message_data.get_string_from_utf8())
	elif socket.get_available_bytes() > 0:
		var to_read: int = socket.get_available_bytes()
		var data: Array = socket.get_data(to_read)
		len -= to_read
		message_data.append_array(data[1])
	return message

func dispatch(message: Dictionary) -> void:
	match message.method:
		"queue_test":
			queued.emit(message.params)
		"run":
			started.emit()
		_:
			pass

func host() -> void:
	close()
	if not server.is_listening():
		server.listen(PORT, ADDRESS)
	
func send(msg: Dictionary) -> void:
	var message = JSON.stringify(msg).to_utf8_buffer()
	socket.put_64(message.size())
	socket.put_data(message)

func recv() -> Variant:
	return json.parse_string(socket.get_utf8_string())
	
func close() -> void:
	if is_hosting():
		socket.disconnect_from_host()
		socket = null
	
func is_hosting() -> bool:
	return socket and socket.get_status() == StreamPeerTCP.STATUS_CONNECTED
