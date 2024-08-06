extends TextureButton

var MIN_WIN_SIZE : Vector2 = Vector2(1200, 640)

var ms_speed : Vector2


func _ready() -> void:
	set_process_input(false)
	modulate = Defaults.btn_inactive_colour
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		ms_speed = event.relative
		get_window().size.x = clamp(get_window().size.x + event.relative.x, MIN_WIN_SIZE.x, DisplayServer.screen_get_size().x - get_window().position.x)
		get_window().size.y = clamp(get_window().size.y + event.relative.y, MIN_WIN_SIZE.y, DisplayServer.screen_get_size().y - get_window().position.y)
	if event is InputEventMouseButton and !event.pressed:
		set_process_input(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.warp_mouse(get_window().size - Vector2i(10,14))
	
	
func _on_ResizeBtn_pressed() -> void:
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ResizeBtn_mouse_entered() -> void:
	modulate = Defaults.btn_active_colour


func _on_ResizeBtn_mouse_exited() -> void:
	modulate = Defaults.btn_inactive_colour
