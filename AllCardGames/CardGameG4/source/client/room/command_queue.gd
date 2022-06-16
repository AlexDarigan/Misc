extends Node
class_name CommandQueue

const _commands: Dictionary = {} # id + gdscript ref
var _queue: Array = [] # 
	
var _initialized: bool = false

func _initalize() -> void:
	var path: String = "res://source/client/room/commands/%s.gd"
	var directory: Directory = Directory.new()
	for command in Dictionary(Enums.CommandId):
		var title = command.capitalize().replace(" ", "_").to_lower()
		var p = path % title
		if directory.file_exists(p): # until all are added
			_commands[Enums.CommandId[command]] = load(p)
	_initialized = true

	
func enqueue(commandId: Enums.CommandId, arguments) -> void:
	if not _initialized:
		_initalize()
	if _commands.has(commandId): # not all commands exist yet
		print(commandId)
		_queue.push_front(_commands[commandId].new(arguments))

func update(game_board) -> void:
	while not _queue.is_empty():
		await _queue.pop_back().execute(game_board)
