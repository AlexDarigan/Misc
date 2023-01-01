extends Node

var filesystem = preload("res://addons/wat/clients/gdscript/filesystem.gd").new()

func _ready():
	filesystem.generate_filesystem()
