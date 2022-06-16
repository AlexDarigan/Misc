extends Node

func _ready() -> void:
	_launch()
	
func _launch() -> void:
	var results: Array = await TestRunner.new().run(TestCollector.new().collect("res://tests"))
	_display(results)
	for result in results:
		if not result.passed:
			push_error("Quitting with Exit Code 1")
			get_tree().quit(1)
	print("Quitting with Exit Code 0")
	get_tree().quit(0)
	
func _display(results: Array) -> void:

	print("\n---BEGIN RESULTS---\n")
	var count: int = 0
	for result in results:
		if result.passed:
			count += 1
	print("%s out of %s test suites passed " % [count, results.size()])
	for result in results:
			if not result.passed:
				print("CLASS")
				print("path: ", result.path)
			#	print("title: ", result.title)
				print("%s out of %s methods passed" % [result.pass_count, result.methods.size()])
				for method in result.methods:
					if not method.passed:
						print()
						print("\tMETHOD")
						print("\tcontext: ", method.context)
						print("\t%s out of %s assertions passed" % [method.pass_count, method.assertions.size()])
					for assertion in method.assertions:
						print()
						if not assertion.passed:
							print("\t\tASSERTION")
							print("\t\tcontext: ", assertion.context)
							print("\t\texpected: ", assertion.expected)
							print("\t\tresult: ", assertion.result)
							print()
	print("\n---END RESULTS---\n")
