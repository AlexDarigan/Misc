tool
extends EditorPlugin

var _p

func _enter_tree():
	_p = load("res://addons/property_shepherd/inspector.gd").new()
	add_inspector_plugin(_p)


func _exit_tree():
	if _p:
		remove_inspector_plugin(_p)
