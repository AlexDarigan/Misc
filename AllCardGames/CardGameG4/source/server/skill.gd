extends RefCounted
class_name CardEffect

var _owner # server card
var _triggers: Array
var _op_codes: Array
var _description: String

func _init(owner, triggers: Array, op_codes: Array, description: String) -> void:
	_owner = owner
	_triggers = triggers
	_op_codes = op_codes
	_description = description
