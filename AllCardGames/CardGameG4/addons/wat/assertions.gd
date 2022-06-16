extends RefCounted
class_name Assertions


signal asserted

func is_true(value: Variant, context: String) -> void:
	var result: AssertionResult = AssertionResult.new()
	result.context = context
	result.expected = "%s is true" % value
	result.result = "%s is false" % value
	result.passed = value == true
	asserted.emit(result)
