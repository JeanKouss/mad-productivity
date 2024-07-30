extends Button

signal charged

@export var instant: bool = false

const LENGTH : float = 1.0

var tweener : Tween

func _ready() -> void:
	Defaults.connect("theme_changed", Callable(self, "on_theme_changed"))
	connect("button_down", Callable(self, "on_button_down"))
	connect("button_up", Callable(self, "on_button_up"))
	tweener.finished.connect(on_tween_done)
	
	
func on_button_down() -> void:
	if instant:
		emit_signal("charged")
		return
	if tweener :
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property($ChargeCol, "scale:x", 1.0, LENGTH)


func on_button_up() -> void:
	tweener.stop()
	$ChargeCol.scale.x = 0.0
	


func on_tween_done() -> void:
	emit_signal("charged")
	$ChargeCol.scale.x = 0.0


func on_theme_changed() -> void:
	$ChargeCol.color = Defaults.ui_theme.highlight_darker
