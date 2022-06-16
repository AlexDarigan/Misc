extends Node

const CARDS: Dictionary = {}
var _initialized: bool = false

func get_card(setcode: String) -> CardInfo:
	if not _initialized:
		_initialize()
	return CARDS[setcode]

func _initialize() -> void:
	CARDS.clear()
	var file: File = File.new()
	file.open("res://source/server/card_library/library.json", File.READ)
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	json.parse(content)
	var library: Dictionary = json.get_data()
	
	for setcode in library:
		var info = library[setcode]
		var title: String = info.Title
		var card_type: Enums.CardTypes = Enums.CardTypes[info.CardType]
		var faction: Enums.Factions = Enums.Factions[info.Faction]
		var power: int = info.Power
		
		var triggers: Array = info.Skill.Triggers
		var op_codes: Array = info.Skill.OpCodes
		var description: String = info.Skill.Description
		
		var skill_info: SkillInfo = SkillInfo.new(triggers, op_codes, description)
		var card_info: CardInfo = CardInfo.new(title, card_type, faction, power, skill_info)
		CARDS[setcode] = card_info
		
	_initialized = true

class CardInfo extends RefCounted:
	
	var title: String
	var card_type: Enums.CardTypes
	var faction: Enums.Factions
	var power: int
	var skill: SkillInfo

	func _init(_title: String, _card_type: Enums.CardTypes, _faction: Enums.Factions, _power: int, _skill: SkillInfo) -> void:
		title = _title
		card_type = _card_type
		faction = _faction
		power = _power
		skill = _skill

class SkillInfo extends RefCounted:
	
	var triggers: Array
	var op_codes: Array
	var description: String
	
	func _init(_triggers: Array, _op_codes: Array, _description: String) -> void:
		
		triggers = _triggers
		description = _description
		
		var get_op_codes = func() -> Array:
			var codes: Array = []
			for code in _op_codes:
				if code in Bytecode.OpCodes:
					codes.append(Bytecode.OpCodes[code])
				elif code in Enums.Factions:
					codes.append(Enums.Factions[code])
				elif code in Enums.CardTypes:
					codes.append(Enums.CardTypes[code])
				else:
					codes.append(code.to_int())
			return codes
		
		op_codes = get_op_codes.call()
		
