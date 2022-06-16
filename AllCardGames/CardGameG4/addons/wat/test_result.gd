extends RefCounted
class_name TestResult

var _current_method: MethodResult
var methods: Array = []
var pass_count: int = 0
var passed: bool = false

var path: String = "": 
	set(value): path = value if path == "" else path

var title: String = "":
	set(value): title = value if title == "" else title

func _init(_path: String, _title: String) -> void:
	path = _path
	title = _title
	
func add_method_context(context: String) -> void:
	_current_method.context = context
	
func add_test_method(method: String) -> void:
	_current_method = MethodResult.new(method)
	methods.append(_current_method)
	
func _on_assertion_made(assertion: AssertionResult) -> void:
	_current_method.assertions.append(assertion)
	_current_method.pass_count += int(assertion.passed)
	
func calculate() -> void:
	for method in methods:
		pass_count += int(not method.assertions.is_empty() and method.pass_count == method.assertions.size())
		method.passed = not method.assertions.is_empty() and method.pass_count == method.assertions.size()
	passed = methods.size() > 0 and pass_count == methods.size()

class MethodResult extends RefCounted:
	var context: String
	var assertions: Array
	var pass_count: int = 0
	var passed: bool = false
	
	func _init(_context: String) -> void:
		context = _context


