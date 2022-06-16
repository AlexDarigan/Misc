extends Node
class_name TestRunner

# Can't use Array[GDScript]
func run(tests: Array) -> Array:
	var results: Array
	while not tests.is_empty():
		var test = tests.pop_back().new()
		results.append(await test.run())
		test.free()
	return results
