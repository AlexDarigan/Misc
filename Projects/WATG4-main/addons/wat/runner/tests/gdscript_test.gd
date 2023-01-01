extends Node
class_name WATTest

var asserts = preload("assertions/api.gd").new()
signal contextualized
signal asserted


func contextualize(_context: String) -> void:
	contextualized.emit(_context)
	
#func asserts(result: bool, context: String) -> void:
#	asserted.emit({
#		"result": result,
#		"context": context,
#	})
