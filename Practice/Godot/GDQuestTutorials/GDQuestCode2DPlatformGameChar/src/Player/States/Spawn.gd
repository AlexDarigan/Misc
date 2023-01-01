extends State

var _start_position := Vector2.ZERO

func _ready() -> void:
	yield(owner, "ready")
	_start_position = owner.position

func _on_Skin_animation_finished(anim_name: String) -> void:
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")
	

func enter(msg: Dictionary = {}) -> void:
	owner.is_active = false
	owner.position = _start_position
	if owner.camera_rig:
		owner.camera_rig.is_active = false
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finished")
	owner.skin.play("spawn")

func exit() -> void:
	owner.is_active = true
	if owner.camera_rig:
		owner.camera_rig.is_active = false
	owner.hook.visible = true
	owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finished")
