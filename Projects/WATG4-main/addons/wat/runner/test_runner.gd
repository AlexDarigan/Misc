@tool
extends Node

@onready var Network: Node = $Network
var queue: Array[Dictionary] = []

func _ready():
	if not Engine.is_editor_hint():
		get_tree().root.mode = Window.MODE_MINIMIZED
	Network.queued.connect(_on_queued)
	Network.started.connect(_on_started)

func _on_queued(test: Dictionary) -> void:
	queue.append(test)
	
func _on_started() -> void:
	for params in queue:
		var controller = preload("tests/gdscript_test_controller.gd").new()
		add_child(controller)
		controller.run(params.path, params.test, params.id)
		Network.send(controller.to_result())
		controller.free()
	queue.clear()
	Network.close()

