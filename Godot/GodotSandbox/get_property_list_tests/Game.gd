tool
extends Node

var _health: int
var _mana: float

var _flock: Dictionary = {}

func _ready():
	if not Engine.is_editor_hint():
		_health = 250
		print(_health)
		_health = 20
		print(_health)
		for prop in get_property_list():
			print(prop)

func _get(property: String):
	return PropertyShepherd.get_property(self, property)
		
func _set(property: String, value) -> bool:
	return PropertyShepherd.set_property(self, property, value)

func _get_property_list() -> Array:
	return PropertyShepherd.get_flock(self)

