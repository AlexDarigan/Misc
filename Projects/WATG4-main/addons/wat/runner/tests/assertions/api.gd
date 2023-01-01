extends RefCounted

const Boolean: GDScript = preload("boolean.gd")

signal asserted

func is_true(value: Variant, context: String = "") -> void:
	asserted.emit(Boolean.is_true(value, context))
	
func is_false(value: Variant, context: String = "") -> void:
	asserted.emit(Boolean.is_false(value, context))
