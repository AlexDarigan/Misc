@tool
extends MenuButton

enum { RUN = 0, DEBUG = 1 }

signal run_tests_selected
signal debug_tests_selected
signal tests_selected

func set_menus(filesystem: RefCounted) -> void:
	get_popup().clear()
	for dir in filesystem.directories:
		var dir_menu: PopupMenu = _add_submenu(
			get_popup(), 
			dir.dirpath, 
			"Directory", 
			dir
		)
		for suite in dir.suites:
			var suite_menu: PopupMenu = _add_submenu(
				dir_menu, 
				suite.filepath, 
				"Suite",
				suite
			)
			for test in suite.tests:
				var test_menu: PopupMenu = _add_submenu(
					suite_menu, 
					test.identifier, 
					"Test",
					test
				)

func _add_submenu(parent: PopupMenu, label: String, what: String, source: RefCounted) -> PopupMenu:
	var menu: PopupMenu = PopupMenu.new()
	parent.add_child(menu)
	menu.name = str(parent.get_child_count())
	parent.add_submenu_item(label, menu.name)
	menu.add_item("Run %s" % what)
	menu.add_item("Debug %s" % what)
	menu.index_pressed.connect(_on_index_pressed.bind(source))
	return menu
	
func _on_index_pressed(index: int, tests: RefCounted) -> void:
	print("index -> ", index)
	match index:
		RUN:
			run_tests_selected.emit(tests)
		DEBUG:
			debug_tests_selected.emit(tests)
		_:
			push_warning("Invalid Run Option")

