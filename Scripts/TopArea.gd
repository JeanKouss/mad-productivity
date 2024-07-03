extends Control

var dragging : = false
var mouse_drag_beg : Vector2
var orig_position : Vector2
var drag_amount : Vector2

var initial_mouse_pos : Vector2

var maximized : bool = false
var minimized_size : Vector2
var minimized_pos : Vector2

var offset : Vector2 

func _ready() -> void:
	if get_window().borderless == false:
		$Right/Maximize.hide()
		$Right/Minimuze.hide()
		$Right/Exit.hide()
		set_process_input(false)
	
	connect_signals()
	var res = load(Defaults.TIMETRACKS_SAVE_PATH + Defaults.TIMETRACKS_SAVE_NAME)	# TODO: access this resource 
		
		
func connect_signals() -> void:
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	Defaults.connect("view_changed", Callable(self, "on_view_changed"))
	Defaults.connect("update_view_info", Callable(self, "on_update_view_info"))
		
		
func _on_mouse_entered() -> void:
	if get_window().borderless == true:
		set_process_input(true)

func _on_mouse_exited() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		initial_mouse_pos = get_global_mouse_position()
		if event.pressed:
			offset = get_global_mouse_position()
		else:
			offset = Vector2()
	if event is InputEventMouseMotion and offset != Vector2():
		if (get_window().mode == Window.MODE_MAXIMIZED):
			offset *=  Defaults.settings_res.minimized_window_size.x / get_window().get_size().x
			$Right/Maximize.button_pressed = false
		get_window().set_position(get_window().get_position() + event.get_global_position() - offset)


func _on_Minimuze_pressed() -> void:
	get_window().mode = Window.MODE_MINIMIZED if (true) else Window.MODE_WINDOWED


func _on_Exit_pressed() -> void:
	Defaults.quit()


func _on_Maximize_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Defaults.settings_res.minimized_window_size = get_window().size
		Defaults.settings_res.minimized_window_position = get_window().position
		Defaults.settings_res.window_maximized = true
		Defaults.save_settings_resource()
		get_window().mode = Window.MODE_MAXIMIZED if (button_pressed) else Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_MAXIMIZED if (false) else Window.MODE_WINDOWED
		Defaults.settings_res.window_maximized = false
		get_window().size = Defaults.settings_res.minimized_window_size
		get_window().position = Defaults.settings_res.minimized_window_position
		Defaults.save_settings_resource()
				

func change_window_title(_name : String) -> void:
	$Left/ViewLabel.text = _name
#	$Tween.stop_all()
#	$Tween.interpolate_property($Right/ViewLabel, "percent_visible", $Right/ViewLabel.percent_visible, 0.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.0)
#	$Tween.interpolate_property($Right/ViewLabel, "percent_visible", 0.0, 1.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)
#	$Tween.start()
#	yield(get_tree().create_timer(0.5), "timeout")
#	$Right/ViewLabel.text = _name 


# IMPORTANT: This func sets up the top area according to how to the new view
func on_view_changed(_name : String, _button : bool, _input_field : bool) -> void:
	change_window_title(_name)
	if _name == "Time tracking":
		$Left/NewBtn.hide()
		$Left/LineEdit.hide()
	else:
		$Left/LineEdit.visible = _input_field
		$Left/NewBtn.visible = _button


func _on_Button_pressed() -> void:
	if Defaults.active_view_pointer and Defaults.active_view_pointer.has_method("on_new_top_bar_button"):
		var message : Dictionary = {}
		if $Left/LineEdit.text != "":
			message.text = $Left/LineEdit.text
			$Left/LineEdit.clear()
		Defaults.active_view_pointer.on_new_top_bar_button(message)


func _on_Shortcuts_shortcut_use() -> void:
	_on_Button_pressed()


func _on_Shortcuts_shortcut_focus() -> void:
	if $Left/LineEdit.visible:
		$Left/LineEdit.grab_focus()


func on_update_view_info(text : String) -> void:
	if text:
		$Right/ViewInfoPanel.show()
		$Right/ViewInfoPanel/ViewInfoLabel.text = text
	else:
		$Right/ViewInfoPanel.hide()
