extends TextureButton

signal toggled_menu_btn

@export var target: String
@export var bottom: bool = false


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	toggled.connect(_on_btn_toggled)
	
	
func _on_mouse_entered() -> void:
	modulate = Defaults.btn_active_colour


func _on_mouse_exited() -> void:
	if button_pressed : return
	modulate = Defaults.btn_inactive_colour


func deactivate() -> void:
	modulate = Defaults.btn_inactive_colour


func _on_btn_toggled(btn_pressed : bool) -> void:
	if btn_pressed:
		modulate = Defaults.btn_active_colour
		toggled_menu_btn.emit()
	else:
		modulate = Defaults.btn_inactive_colour
