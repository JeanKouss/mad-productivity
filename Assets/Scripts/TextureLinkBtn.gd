extends TextureButton

@export var target_link: String
@export var theme_highlight := false

func _ready() -> void:
	modulate.a = 0.3
	connect("mouse_entered", Callable(self, "on_mouse_entered"))
	connect("mouse_exited", Callable(self, "on_mouse_exited"))
	connect("pressed", Callable(self, "on_pressed"))
	
	
func on_mouse_exited() -> void:
	modulate = Color.WHITE
	modulate.a = 0.3
	
	
func on_mouse_entered() -> void:
	if theme_highlight:
		modulate = Defaults.ui_theme.highlight_colour
	else:
		modulate = Color.WHITE
	
	
func on_pressed() -> void:
	if target_link:
		OS.shell_open(target_link)
