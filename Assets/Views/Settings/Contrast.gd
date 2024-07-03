extends HBoxContainer


func _ready() -> void:
	$Option.value = Defaults.ui_theme.contrast


func _on_CatTheme_values_updated() -> void:
	$Option.value = Defaults.ui_theme.contrast
