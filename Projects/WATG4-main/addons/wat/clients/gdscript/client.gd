@tool
extends PanelContainer

const RUNNER: String = "res://addons/wat/runner/TestRunner.tscn"
@onready var TestRunner: Node = $TestRunner
@onready var RunButton: Button = $VBoxContainer/Options/Run
@onready var DropDown: MenuButton = $VBoxContainer/Options/MenuButton
@onready var Results: Tree = $VBoxContainer/Results
@onready var Network: Node = $Network
var filesystem: RefCounted
var runner: Node

# _ready triggers if this is simply the open scene, so
# ..so we will use plugin to initialize it externally
func initialize() -> void:
	RunButton.pressed.connect(_on_run_pressed)
	DropDown.about_to_popup.connect(_on_DropDown_about_to_popup)
	DropDown.run_tests_selected.connect(_on_run_tests_selected)
	DropDown.debug_tests_selected.connect(_on_debug_tests_selected)
	Network.responded.connect(Results._on_results_received)
	
func _on_Network_disconnected_from_host() -> void:
	if runner:
		runner.queue_free()

func _on_DropDown_about_to_popup() -> void:
	filesystem.scan()
	DropDown.set_menus(filesystem)

func _on_run_pressed() -> void:
	print("Run All Not Implemented")
	
func _on_run_tests_selected(tests) -> void:
	print("run callback")
	Network.generate_requests(tests)
	print("B")
	Results.generate_tree(tests)
	print("C")
	print("D")
	print("E")
	TestRunner.Network.host()
	print("G")
	Network.join()
	print("H")
	EditorPlugin.new().make_bottom_panel_item_visible(self)
	
func _on_debug_tests_selected(tests) -> void:
	print("debug callback")
	Network.generate_requests(tests)
	Results.generate_tree(tests)
	EditorPlugin.new().get_editor_interface().play_custom_scene(RUNNER)
	Network.join()
	EditorPlugin.new().make_bottom_panel_item_visible(self)
	
func shutdown() -> void:
	Network.shutdown()
