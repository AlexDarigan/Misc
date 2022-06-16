extends EditorInspectorPlugin

func can_handle(object) -> bool:
	# The callbacks won't trigger on non-tool scripts
	return object.get_script() != null and object.get_script().is_tool()
	
func parse_begin(object) -> void:
	add_property_editor("Property Exporter", preload("property_menu.gd").new(object))
