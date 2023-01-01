extends RefCounted
class_name MyFileSystem

const TestGroup: GDScript = preload("test_group.gd")
var directories: Array = []

func scan(root: String = "res://tests") -> void:
	directories.clear()
	var dirpaths: PackedStringArray = DirAccess.get_directories_at(root)
	for dirpath in dirpaths:
		var respath: String = "%s/%s" % [root, dirpath]
		var filepaths: PackedStringArray = DirAccess.get_files_at(respath)
		var suites: Array = []
		for filepath in filepaths:
			var suitepath = "%s/%s" % [respath, filepath]
			var tests: Array = []
			for method in load(suitepath).get_script_method_list():
				if method.name.begins_with("test"):
					tests.append(TestGroup.get_test(respath, suitepath, method.name))
			suites.append(TestGroup.get_suite(respath, suitepath, tests))
		directories.append(TestGroup.get_directory(respath, suites))
