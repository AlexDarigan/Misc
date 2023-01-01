extends Control

onready var title: Label = $Score

func _ready() -> void:
	title.text = title.text % [PlayerData.score, PlayerData.deaths]
