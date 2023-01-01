extends RefCounted

# Multi-functional job of being a dir, suite, or test depending on use
# by doing some complications down here, we reduce code elsewhere

# Because we can do things like run a dir, file or method, we create each of them from a..
# ..version of this class with oddities like a test method containing only itself, so that it
# ..can be treated like a suite. This allows us to treat them uniformly elsewhere in a simple nested
# ..for loop

var id: String
var identifier: String
var dirpath: String
var filepath: String
var suites: Array = []
var tests: Array = []

static func get_directory(_dirpath: String, _suites: Array) -> RefCounted:
	var dir: RefCounted = new()
	dir.dirpath = _dirpath
	dir.suites = _suites
	return dir
	
static func get_suite(_dirpath: String, _filepath: String, _tests: Array) -> RefCounted:
	var suite: RefCounted = new()
	suite.dirpath = _dirpath
	suite.filepath = _filepath
	suite.tests = _tests
	suite.suites.append(suite)
	return suite
	
static func get_test(_dirpath: String, _filepath: String, _identifier: String) -> RefCounted:
	# Do I need to generate a suite here too?
	var test: RefCounted = new()
	test.dirpath = _dirpath
	test.filepath = _filepath
	test.identifier = _identifier
	test.id = str(hash(test))
	test.suites.append(test)
	test.tests.append(test)
	return test
