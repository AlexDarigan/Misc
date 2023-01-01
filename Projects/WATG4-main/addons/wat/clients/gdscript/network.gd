@tool
extends Node

const PORT: int = 5000
const ADDRESS: String = "127.0.0.1"
var socket: StreamPeerTCP
var jsonrpc: JSONRPC = JSONRPC.new()
var json: JSON = JSON.new()
var tests: Array = []
var requests: int = 0
var responses: int = 0
var sent: bool = false
signal responded
var len: int = 0
var message_data: PackedByteArray = []

func _process(delta) -> void:
	if not socket:
		return
	socket.poll()
	if is_connected_to_host():
		send_messages()
	if responses >= requests:
		return
	var message = get_message()
	if message != null:
		dispatch(message)
		
func get_message() -> Variant:
	if len == 0 and socket.get_available_bytes() >= 64:
		len = socket.get_64()
		message_data.clear()
		return null
	elif len > 0 and socket.get_available_bytes() >= len:
		var data = socket.get_data(len)
		message_data.append_array(data[1])
		len = 0
		var message = JSON.parse_string(message_data.get_string_from_utf8())
		return message
	elif socket.get_available_bytes() > 0:
		var to_read: int = socket.get_available_bytes()
		var data = socket.get_data(to_read)
		len -= to_read
		message_data.append_array(data[1])
		return null
	return null

func dispatch(message) -> void:
	responses += 1
	responded.emit(message)

func join() -> void:
	leave()
	socket = StreamPeerTCP.new()
	socket.connect_to_host(ADDRESS, PORT)
	
func send(msg: Dictionary) -> void:
	var message = JSON.stringify(msg).to_utf8_buffer()
	socket.put_64(message.size())
	socket.put_data(message)
	
func recv() -> Variant:
	return JSON.parse_string(socket.get_utf8_string())
	
func leave() -> void:
	if is_connected_to_host():
		socket.disconnect_from_host()
		
func generate_requests(source: RefCounted) -> void:
	tests = []
	for suite in source.suites:
		for test in suite.tests:
			tests.append(make_run_request(test))
	requests = tests.size()
	responses = 0
	sent = false

func send_messages() -> void:
	if sent:
		return
	sent = true
	for test in tests:
		send(test)
	send(start_request())
		
func is_connected_to_host() -> bool:
	return socket and socket.get_status() == StreamPeerTCP.STATUS_CONNECTED

func start_request() -> Dictionary:
	return jsonrpc.make_request("run", {}, str(hash(self)))

func make_run_request(source: RefCounted) -> Dictionary:
	return jsonrpc.make_request("queue_test", {
		"path": source.filepath,
		"test": source.identifier,
		"id": source.id
	}, source.id)

func shutdown() -> void:
	leave()
