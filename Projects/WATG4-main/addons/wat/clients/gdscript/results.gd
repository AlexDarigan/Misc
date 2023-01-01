@tool 
extends Tree

var _test_items: Dictionary = {}

func _ready() -> void:
	pass

func generate_tree(tests: RefCounted) -> void:
	clear()
	_test_items.clear()
	var root: TreeItem = create_item()
	for suite in tests.suites:
		var suite_item: TreeItem = root.create_child()
		suite_item.set_text(0, suite.filepath)
		for test in suite.tests:
			var test_item: TreeItem = suite_item.create_child()
			test_item.set_text(0, test.identifier)
			_test_items[test.id] = test_item

func _on_results_received(test: Dictionary) -> void:
	var test_item: TreeItem = _test_items[test.id]
	var total: int = 0
	var passed: int = 0
	for assertion in test.result:
		total += 1
		var assertion_item: TreeItem = test_item.create_child()
		assertion_item.set_text(0, assertion.context)
		if assertion.result == true:
			passed += 1
			assertion_item.set_custom_color(0, Color(0, 1, 0))
	if passed == total:
		test_item.set_custom_color(0, Color(0, 1, 0))

