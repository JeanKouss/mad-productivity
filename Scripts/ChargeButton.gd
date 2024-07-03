extends Button

signal charged

@export var instant: bool = false

const LENGTH : float = 1.0


func _ready() -> void:
	Defaults.connect("theme_changed", Callable(self, "on_theme_changed"))
	connect("button_down", Callable(self, "on_button_down"))
	connect("button_up", Callable(self, "on_button_up"))
	$Tween.connect("tween_all_completed", Callable(self, "on_tween_done"))
	
	
func on_button_down() -> void:
	if instant:
		emit_signal("charged")
		return
	$Tween.interpolate_property($ChargeCol, "scale:x", $ChargeCol.scale.x, 1.0, LENGTH, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)
	$Tween.start()


func on_button_up() -> void:
	$Tween.stop_all()
	$Tween.remove_all()
	$ChargeCol.scale.x = 0.0
	


func on_tween_done() -> void:
	emit_signal("charged")
	$ChargeCol.scale.x = 0.0


func on_theme_changed() -> void:
	$ChargeCol.color = Defaults.ui_theme.highlight_darker
