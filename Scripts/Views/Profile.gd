extends Control


@export var title : String

var res : SettingsResource

# UI state machine functions
func entering_view() -> void:
	Defaults.active_view_pointer = self
	Defaults.emit_signal("view_changed", title, false, false)
	update_view_text()
	
	
func leaving_view() -> void:
	pass
	
	
func save() -> void:
	Defaults.save_settings_resource()


func _ready() -> void:
	res = Defaults.settings_res
	$VBoxContainer/UserName.text = res.name
	$VBoxContainer/UserTitle.text = res.title
	update_theme()
	Defaults.connect("theme_changed", Callable(self, "on_theme_changed"))


func update_theme() -> void:
	$VBoxContainer/UserName.add_theme_color_override("font_color", Defaults.ui_theme.highlight_colour)


func update_view_text() -> void:
	var text : String = ""
	Defaults.emit_signal("update_view_info", text)
	

## SIGNALS

func _on_UserName_text_changed(new_text: String) -> void:
	res.name = new_text


func _on_UserTitle_text_changed(new_text: String) -> void:
	res.title = new_text


func on_theme_changed() -> void:
	update_theme()
