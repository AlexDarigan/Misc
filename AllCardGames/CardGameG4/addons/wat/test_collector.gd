extends RefCounted
class_name TestCollector


func collect(path: String) -> Array:
	var dir: Directory = Directory.new()
	dir.include_hidden = false
	dir.include_navigational = false
	if dir.open(path) != OK:
		push_error("bad access")
		return []
	var files = dir.get_files()
	var tests: Array
	for p in files:
		if load("%s/%s" % [path, p]).get("IsTest"):
			tests.append(load("%s/%s" % [path, p]))
	return tests
	
