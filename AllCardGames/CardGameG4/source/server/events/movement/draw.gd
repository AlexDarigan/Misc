extends MoveGameEvent
class_name DrawEvent

func queue_on_clients(queue: Callable) -> void:
	queue.call(_controller.id, Enums.CommandId.PlayerDraw, _card.id)
	queue.call(_controller.opponent.id, Enums.CommandId.RivalDraw)
