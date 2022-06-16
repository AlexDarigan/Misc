extends Node

const SERVER: PackedScene = preload("res://source/server/Server.tscn")
const CLIENT: PackedScene = preload("res://source/client/room/Room.tscn")
var server: Window
var room_1: Window
var room_2: Window

func _ready() -> void:
	
	var root: Window = get_tree().root
	root.gui_embed_subwindows = false
	
	server = SERVER.instantiate()
	room_1 = CLIENT.instantiate()
	room_2 = CLIENT.instantiate()

	
	server.visible = false
	root.current_screen = 0
	room_1.current_screen = 1
	room_2.current_screen = 2
	room_1.cull_mask = 2
	room_2.cull_mask = 1
	room_1.size = root.size
	room_2.size = root.size
	server.name = "Server"
	room_1.title = "Room 1"
	room_2.title = "Room 2"
	room_1.position = root.position
	room_2.position = root.position
	
	add_child(server)
	add_child(room_1)
	add_child(room_2)

	room_1.join()
	room_2.join()
