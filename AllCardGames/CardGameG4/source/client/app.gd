extends Control

var user: User = User.new()
@onready var _deck_list_menu: Control = $DeckListMenu
@onready var _main_menu: Control = $MainMenu
@onready var _deck_editor: Control = $DeckEditor
@onready var _user_profile: Control = $UserProfile
@onready var _settings: Control = $Settings
@onready var _room: ClientRoom = $Room
@onready var _current_screen: Control
@onready var _display_name: String

func _init() -> void:
	var args = OS.get_cmdline_args()
	if args.size() > 1 and not Engine.is_editor_hint():
		_display_name = args.pop_front()
		OS.window_title = _display_name
		OS.current_screen = args.pop_front().to_int()
		OS.window_fullscreen = true
		
func _ready() -> void:

	_deck_list_menu.user = user;
	_room.user = user;
	_deck_editor.user = user;
	_user_profile.user = user;
	_settings.user = user;

	_main_menu.get_node("Play").button_down.connect(_display_screen.bind(_room))
	_main_menu.get_node("DeckEditor").button_down.connect(_display_screen.bind(_deck_editor))
	_main_menu.get_node("UserProfile").button_down.connect(_display_screen.bind(_user_profile))
	_main_menu.get_node("Settings").button_down.connect(_display_screen.bind(_settings))
	_main_menu.get_node("Quit").button_down.connect(get_tree().quit)
	$DisplayName.text = _display_name
	
func display() -> void:
	show()
	if _current_screen == _room:
		_room.display()
		
func stop_displaying() -> void:
	hide()
	if _room:
		_room.stop_displaying()
		
func _display_screen(_new_screen: Control) -> void:
	if _current_screen:
		_current_screen.stop_displaying()
	_current_screen = _new_screen
	_current_screen.display()
