extends RefCounted
class_name GameEvent

func queue_on_clients(queue: Callable) -> void:
	push_error("Abstract Method Called")
