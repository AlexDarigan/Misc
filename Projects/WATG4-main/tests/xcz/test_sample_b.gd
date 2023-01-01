extends WATTest

func test_nonsense() -> void:
	asserts.is_true(10 > 5, "10 > 5")
	
func test_other_nonsense() -> void:
	asserts.is_true("abc" != "cde", "abc != cde")
	
func test_more_crap() -> void:
	asserts.is_true("hello".contains("e"), "hello contains e")
