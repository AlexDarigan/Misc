extends RefCounted
class_name MatchMaker

signal match_made
var _players: Array = []
var _rooms: Array = []

func queue_player(player) -> void:
	_players.append(player)

func update() -> void:
	if _players.size() > 1:
		_create_room()
		
func _create_room() -> void:
	var p1: ServerPlayer = _players.pop_back()
	var p2: ServerPlayer = _players.pop_back()
	var count: String = str(_rooms.size())
	var room: ServerRoom = ServerRoom.new(p1, p2)
	room.name = count as String
	_rooms.append(room)
	match_made.emit(p1, p2, room)
