extends Event
class_name SetHealth

var new_health: int
var damaged: Player

func _init(player: Player) -> void:
	new_health = player.health
	damaged = player
