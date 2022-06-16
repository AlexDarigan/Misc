extends Node
class_name Test

const IsTest: bool = true
var asserts: Assertions = preload("res://addons/wat/assertions.gd").new()
var _result: TestResult = TestResult.new(get_script().resource_path, name)

func title() -> String:
	return get_script().resource_path
	
func describe(description: String) -> void:
	_result.add_method_context(description)

func run() -> TestResult:
	asserts.asserted.connect(_result._on_assertion_made)
	await start()
	for test in _tests():
		_result.add_test_method(test.name)
		await pre()
		await test.function.call()
		await post()
	await end()
	_result.calculate()
	return _result
	
func start() -> void:
	pass
	
func pre() -> void:
	pass
	
func post() -> void:
	pass
	
func end() -> void:
	pass

func _tests() -> Array[Dictionary]:
	var callables: Array[Dictionary]
	for method in get_method_list():
		if method.name.begins_with("test"):
			callables.append({"name": method.name, "function": Callable(self, method.name)})
	for property in get_property_list():
		if property.name.begins_with("test") and get(property.name) is Callable:
			callables.append({"name": property.name, "function": get(property.name)})
	return callables


