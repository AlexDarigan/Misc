extends Node3D
class_name ClientCard


const THICKNESS: float = 0.003
const WIDTH: float = 0.59
const LENGTH: float = 0.86
signal card_pressed
var id: int = 0:
	set(value): id = value if id == 0 else id # -1?
var art: Texture:
	set(texture): _face_material.albedo_texture = texture
var state: Enums.CardStates
var _face_material: Material
# current_zone (?)

func _ready() -> void:
	_face_material = $Plane.mesh.surface_get_material(0)
	$Area3D.input_event.connect(_on_input_event)
	$Area3D.mouse_entered.connect(_on_mouse_entered)
	
func _on_mouse_entered():
	print("mouse enter ", name)
	
func _on_input_event(camera, input, click_position, click_normal, shape_idx) -> void:
	
	if input is InputEventMouseButton and input.button_index == MOUSE_BUTTON_LEFT and input.double_click:
		print("clicked ", name)
		card_pressed.emit(self)

func _set_materials() -> void:
	pass
