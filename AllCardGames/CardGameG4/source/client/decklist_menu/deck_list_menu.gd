extends OptionButton

var user: User

func _init() -> void:
	
	item_selected.connect(_on_deck_selected)
	get_popup().about_to_popup.connect(_on_about_to_popup)
	
func _on_about_to_popup() -> void:
	clear()
	get_popup().reset_size()
	add_item("Select Deck")
	var files: Array = []
	for file in files:
		pass
		# add file with sanitized name
	
func _on_deck_selected() -> void:
	pass # user.current_deck = load("decklistpath")
