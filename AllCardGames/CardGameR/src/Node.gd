extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var output = []
	OS.execute("CMD.exe", ["godotmono", "--no-window"], false, output)
	print(output)
