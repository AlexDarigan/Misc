extends Node

var _id: String
var context: String
var assertions: Array[Dictionary] = []

func run(path: String, identifier: String, id: String) -> void:
	print(path, " / ", identifier, " / ", id)
	_id = id
	var test = load(path).new()
	test.contextualized.connect(_on_contextualized)
	test.asserts.asserted.connect(_on_asserted)
#	test.asserted.connect(_on_asserted)
	# Execution may require check with has_method() and has_property
	test.call(identifier)
	print(assertions)
	
func _on_contextualized(_context: String) -> void:
	context = _context
	
func _on_asserted(assertion: Dictionary) -> void:
	assertions.append(assertion)
	
func to_result() -> Dictionary:
	return {
		"jsonrpc": "2.0",
		"result": assertions,
		"id": _id,
	}
