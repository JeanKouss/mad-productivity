extends Panel

@export var views_state_provider : Main

@onready var views_buttons : Dictionary = {
	'home' : %HomeButton,
	'notes' : %NotesButton,
	'time_tracks' : %TimeTracksButton,
	'todos' : %TodosButton,
	'games' : %GamesButtons,
	'profile' : %ProfileButton,
	'settings' : %SettingsButton,
}


signal time_tracking_requested
signal home_requested
signal notes_requested
signal time_tracks_requested
signal todos_requested
signal games_requested
signal profile_requested
signal settings_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	views_state_provider.cur_view_changed.connect(_on_cur_view_changed)
	views_state_provider.time_tracking_panel_toggle.connect(_on_time_tracking_panel_toggle)


func _on_cur_view_changed(from:String, to:String) :
	views_buttons[from].active = false
	views_buttons[to].active = true

func _on_time_tracking_panel_toggle(active:bool) :
	%TimeTrackingButton.active = active

## Buttons pressed signals

func _on_time_tracking_button_pressed() -> void:
	time_tracking_requested.emit()

func _on_home_button_pressed() -> void:
	home_requested.emit()

func _on_notes_button_pressed() -> void:
	notes_requested.emit()

func _on_time_tracks_button_pressed() -> void:
	time_tracks_requested.emit()

func _on_todos_button_pressed() -> void:
	todos_requested.emit()

func _on_games_buttons_pressed() -> void:
	games_requested.emit()

func _on_profile_button_pressed() -> void:
	profile_requested.emit()

func _on_settings_button_pressed() -> void:
	settings_requested.emit()
