extends Label

onready var _start_msec: float = OS.get_ticks_msec()

# warning-ignore:unused_argument
func _physics_process(delta) -> void:
	text = str((OS.get_ticks_msec() - _start_msec) / 1000).substr(0, 4)
