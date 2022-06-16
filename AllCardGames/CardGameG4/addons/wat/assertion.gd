extends RefCounted

var success: String = "":
	set(value): success = value if success != "" else success
	
var expected: String = "":
	set(value): expected = value if expected != "" else expected

var context: String = "":
	set(value): context = value if context != "" else context
