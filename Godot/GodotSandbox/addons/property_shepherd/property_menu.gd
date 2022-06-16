extends EditorProperty

const PropertyExporter: PackedScene = preload("PropertyExporter.tscn")
var _exporter = PropertyExporter.instance()
var _obj

func _init(_object) -> void:
	label = "Property Exporter"
	_obj = _object
	checkable = true
	connect("property_checked", self, "_on_property_checked")

func _on_property_checked(a, b):
	_exporter.get_node("Button").emit_signal("pressed")

func _ready() -> void:
	add_child(_exporter)
	set_bottom_editor(_exporter)
	_set_properties()
	
func _exit_tree():
	_exporter.queue_free()
	
func _set_properties() -> void:
	# Check if already linked (and show if so)
	for prop in _obj.get_script().get_script_property_list():
		_exporter.get_node("Grid/PropertyList").add_item(prop.name)

func _set_categories() -> void:
	pass
	
func _set_groups() -> void:
	pass
