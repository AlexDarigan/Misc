extends Node

const CARDS: Dictionary = {}
var _initialized: bool = false

func get_card(setcode: String):
	if not _initialized:
		_initialize()
	return CARDS[setcode]
	
func _initialize() -> void:
	CARDS.clear()
	
	var file: File = File.new()
	file.open("res://source/client/card_library/library.json", File.READ)
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	json.parse(content)
	var library: Dictionary = json.get_data()
	
	for setcode in library:
		var info = library[setcode]
		var card_info = CardInfo.new()
		
		card_info.title = info.Title
		card_info.card_type = Enums.CardTypes[info.CardType]
		card_info.faction = Enums.Factions[info.Faction]
		card_info.power = info.Power
		card_info.text = info.Text
		card_info.art = load(info.Art)
		CARDS[setcode] = card_info
		
	_initialized = true
	
class CardInfo extends RefCounted:
	var title: String
	var card_type: Enums.CardTypes
	var faction: Enums.Factions
	var power: int
	var text: String
	var art: Texture
