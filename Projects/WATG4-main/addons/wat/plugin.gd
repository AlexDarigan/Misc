@tool
extends EditorPlugin


const NAME: String = "Tests"
const GDScriptClient: PackedScene = preload("res://addons/wat/clients/gdscript/Client.tscn")
const FileSystem: GDScript = preload("res://addons/wat/clients/gdscript/filesystem.gd")
var client: Control = GDScriptClient.instantiate()
var filesystem: FileSystem = FileSystem.new()

func _enter_tree() -> void:
	client.filesystem = filesystem
	add_control_to_bottom_panel(client, NAME)
	client.initialize()

func _exit_tree() -> void:
	if client:
		client.shutdown()
		remove_control_from_bottom_panel(client)
		client.free()

func on_changed():
	print("CHANGED")
