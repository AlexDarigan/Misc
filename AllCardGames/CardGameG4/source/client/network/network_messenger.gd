extends Node
class_name ClientMessenger

signal event_queued
signal updated

@rpc(authority)
func queue(commandId: Enums.CommandId, args) -> void:
	event_queued.emit(commandId, args)

@rpc(authority)
func update() -> void:
	updated.emit()

# dummy methods
@rpc(any_peer)
func _on_client_ready() -> void:
	pass
	
@rpc
func deploy(id: int) -> void:
	pass

@rpc
func set_facedown(id: int) -> void:
	pass

@rpc
func attack_unit(attackerId: int, defenderId: int) -> void:
	pass

@rpc
func attack_player(id: int) -> void:
	pass

@rpc
func activate(id: int) -> void:
	pass

@rpc
func pass_play() -> void:
	pass

@rpc
func end_turn() -> void:
	pass
