extends WATTest


func test_nonsense() -> void:
	asserts.is_true(true == true, "true is true")
	
func test_other_nonsense() -> void:
	asserts.is_true(true != false, "true is not false")
	
func test_false_is_not_null() -> void:
	asserts.is_true(false != null, "false is not null")

