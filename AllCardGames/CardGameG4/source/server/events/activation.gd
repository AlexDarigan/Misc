extends GameEvent
class_name ActivationEvent

var _player: ServerPlayer
var _activated: ServerCard

func _init(player: ServerPlayer, activated: ServerCard) -> void:
	_player = player
	_activated = activated
	
func queue_on_clients(queue: Callable) -> void:
	queue.call(_player.id, Enums.CommandId.PlayerActivate, _activated.id)
	queue.call(_player.id, Enums.CommandId.RivalActivate, _activated.Id, _activated.setcode)
