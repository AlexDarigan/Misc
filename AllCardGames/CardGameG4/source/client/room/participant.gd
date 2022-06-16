extends Node
class_name Participant

@onready var deck: Zone = Zone.new($DeckHint)
@onready var discard: Zone = Zone.new($DiscardHint)
@onready var hand: Zone = Zone.new($HandHint)
@onready var units: Zone = Zone.new($UnitsHint)
@onready var supports: Zone = Zone.new($SupportsHint)
@onready var state: Enums.States

func _ready() -> void:
	add_child(deck)
	add_child(discard)
	add_child(hand)
	add_child(units)
	add_child(supports)
	deck.name = "Deck"
	discard.name = "Discard"
	hand.name = "Hand"
	units.name = "Units"
	supports.name = "Supports"
