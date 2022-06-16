extends MoveGameEvent
class_name SentToGraveyardEvent

func queue_on_clients(queue: Callable) -> void:
	queue.call(_card.owner.id, Enums.CommandId.SentToGraveyard, _card.id)
	queue.call(_card.owner.opponent.id, Enums.CommandId.SentToGraveyard, _card.id)
