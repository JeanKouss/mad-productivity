extends HBoxContainer

signal values_updated

var color_int : int = 0
var color_node : ColorRect

func _ready() -> void:
	pass # Replace with function body.
	
	
func _update_values() -> void:
	emit_signal("values_updated")
	
	

func _on_ColorPicker_color_changed(color: Color) -> void:
	if color_node:
		Defaults.ui_theme.set_color(color_int, color)
		color_node.color = color


func _on_Option_setting_color(which : int, node : ColorRect) -> void:
	color_int = which
	color_node = node


func _on_Option_value_changed(value: float) -> void:
	Defaults.ui_theme.contrast = value
	Defaults.update_theme()
