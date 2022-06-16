extends MoveGameEvent
class_name SetFacedownEvent

func queue_on_clients(queue: Callable) -> void:
	queue.call(_controller.Id, Enums.CommandId.PlayerSetFaceDown, _card.Id);
	queue.call(_controller.Opponent.Id, Enums.CommandId.RivalSetFaceDown);
