extends Node3D
class_name Table

signal pass_play_pressed
var _material: StandardMaterial3D

func _ready() -> void:
	_material = $PassPlayButton.get_surface_override_material(0)
	$PassPlayButton/Area3D.input_event.connect(_on_input_event)
	
func _on_input_event(cam, input, clickpos, clicknormal, shapeidx) -> void:
	if input is InputEventMouseButton and input.button_index == MOUSE_BUTTON_LEFT and input.double_click:
		pass_play_pressed.emit()
		
func set_state(state: Enums.States) -> void:
	print("setting state to ", state)
	match state:
		Enums.States.IdleTurnPlayer:
			print("Idle green")
			_material.albedo_color = Color.FOREST_GREEN
		Enums.States.Active:
			print("Active green")
			_material.albedo_color = Color.FOREST_GREEN
		_:
			print("other red")
			_material.albedo_color = Color.RED
			
func set_as_inactive() -> void:
	_material.albedo_color = Color.FOREST_GREEN
