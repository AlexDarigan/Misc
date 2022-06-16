extends Node
class_name Zone

var _hint: Position3D
var _cards: Array = []

func _init(hint: Position3D) -> void:
	_hint = hint
	
func add(card: ClientCard) -> void:
	_cards.append(card)
	add_child(card)
	
func remove(card: ClientCard) -> void:
	_cards.erase(card)
	remove_child(card)
	
func shift(offset: Vector3) -> void:
	_hint.position += offset
	
func update(offset: Vector3) -> void:
	for card in _cards:
		# Is position, the new form, of translation in 4?
		card.position = _hint.position + offset * card.get_index()
		card.rotation = _hint.rotation # euler, radians, this used to be degrees
		
func update2(offset: Vector3, game_board) -> void:
	
	var t = game_board.effects.gfx
	for card in _cards:
		t.tween_property(card, "position", _hint.position + offset * card.get_index(), .2)
		t.tween_property(card, "rotation", _hint.rotation, .2)
