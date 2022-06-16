extends Node
class_name PropertyShepherd

static func get_flock(object: Object) -> Array:
	return [
		{"name": "My Category", "type": TYPE_NIL, "usage": PROPERTY_USAGE_CATEGORY},
		{
		"name": "Script Variables/Health", "type": TYPE_INT,
	}
	]

static func set_property(object: Object, property: String, value) -> bool:
	if property == "Script Variables/Health":
		object.set("_health", value) ## = value
	return true

static func get_property(object: Object, property: String):
	if property == "Script Variables/Health":
		return object.get("_health")
