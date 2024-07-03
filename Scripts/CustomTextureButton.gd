extends TextureButton

signal toggled_menu_btn

@export var target: String
@export var bottom: bool = false


func _ready() -> void:
	connect("mouse_entered", Callable(self, "mouse_entered"))
	connect("mouse_exited", Callable(self, "mouse_exited"))
	connect("toggled", Callable(self, "btn_toggled"))
	
	
func mouse_entered() -> void:
	modulate = Defaults.btn_active_colour


func mouse_exited() -> void:
	if pressed: return
	modulate = Defaults.btn_inactive_colour


func deactivate() -> void:
	modulate = Defaults.btn_inactive_colour


func btn_toggled(btn_pressed : bool) -> void:
	if btn_pressed:
		modulate = Defaults.btn_active_colour
		emit_signal("toggled_menu_btn")
	else:
		modulate = Defaults.btn_inactive_colour
