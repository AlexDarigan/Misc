tool
extends Resource
class_name MyResource

var _health: int

func _get(property):
	if property == "Health":
		return _health
		
func _set(property, value) -> bool:
	return PropertyShepherd.set_property(self, property, value)
	
	
func _get_property_list() -> Array:
	return PropertyShepherd.get_flock(self)
