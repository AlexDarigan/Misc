extends Spatial
class_name Mannequiny

enum States { IDLE, RUN, AIR }

onready var animation_tree: AnimationTree = $AnimationTree
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var move_direction := Vector3.ZERO setget set_move_direction

func _ready() -> void:
	animation_tree.active = true

func set_move_direction(direction: Vector3) -> void:
	move_direction = direction
	animation_tree["parameters/move_ground/blend_position"] = direction.length()

func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel("idle")
		States.RUN:
			_playback.travel("move_ground")
		States.AIR:
			_playback.travel("jump")
		_:
			_playback.travel("idle")
