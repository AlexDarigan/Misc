extends RefCounted

var passed: bool = false
var context: String = ""
var pass_msg: String = ""
var fail_msg: String = ""

static func _result(
	success: bool, 
	expected: String, 
	actual: String, 
	context: String ) -> Dictionary:
	return {
		"result": success,
		"expected": expected,
		"actual": actual,
		"context": context
	}

# TODO: Expand / Rename Types
static func type2str(property) -> String:
	match typeof(property):
		TYPE_NIL:
			return "null"
		TYPE_BOOL:
			return "bool"
		TYPE_INT:
			return "int"
		TYPE_FLOAT:
			return "float"
		TYPE_STRING:
			return "String"
		TYPE_VECTOR2:
			return "Vector2"
		TYPE_RECT2:
			return "Rect2"
		TYPE_VECTOR3:
			return "Vector3"
		TYPE_TRANSFORM2D:
			return "Transform2D"
		TYPE_PLANE:
			return "Plane"
		TYPE_QUATERNION:
			return "Quat"
		TYPE_AABB:
			return "AABB"
		TYPE_BASIS:
			return "Basis"
		TYPE_TRANSFORM3D:
			return "Transform"
		TYPE_COLOR:
			return "Color"
		TYPE_NODE_PATH:
			return "NodePath"
		TYPE_RID:
			return "RID"
		TYPE_OBJECT:
			return "Object"
		TYPE_DICTIONARY:
			return "Dictionary"
		TYPE_ARRAY:
			return "Array"
		TYPE_PACKED_BYTE_ARRAY:
			return "PoolByteArray"
		TYPE_PACKED_INT64_ARRAY:
			return "PoolIntArray"
		TYPE_PACKED_FLOAT64_ARRAY:
			return "PoolRealArray"
		TYPE_PACKED_STRING_ARRAY:
			return "PoolStringArray"
		TYPE_PACKED_VECTOR2_ARRAY:
			return "PoolVector2Array"
		TYPE_PACKED_VECTOR3_ARRAY:
			return "PoolVector3Array"
		TYPE_PACKED_COLOR_ARRAY:
			return "PoolColorArray"
	return "OutOfBounds"
