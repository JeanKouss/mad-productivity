extends ColorRect

signal setting_color(which, node)

@export var color_setted : int # (int, "primary_col", "highlight_colour", "text_color")

var value : Color 


func _ready() -> void:
	value = Defaults.ui_theme.get_color(color_setted)
	color = value
	connect("gui_input", Callable(self, "on_gui_input"))


func update_values() -> void:
	value = Defaults.ui_theme.get_color(color_setted)
	color = value
	

func on_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("setting_color", color_setted, self)


func _on_CatTheme_values_updated() -> void:
	update_values()
