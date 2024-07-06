extends Panel

signal view_changed(which, target)

var buttons : Array


var active_btn : TextureButton

var previous_random_view : int = -1
var previous_view : int

var number_of_views : int = 0

var tweener = create_tween()

func _ready() -> void:
	update_theme()
	update_particles()
	connect_signals()
	time_track_panel_ready()
	var idx : int = 0
	
	for i in $Buttons.get_children():
		if i is TextureButton and i.get("target"):
			buttons.append(i)
			i.connect("toggled_menu_btn", Callable(self, "on_toggled_menu_btn").bind(i, idx, i.target))
			idx += 1
	number_of_views = idx



func update_particles() -> void:
	$SelectionBox/Particles.emitting = Defaults.settings_res.particle_effect
	$SelectionBox/Particles.visible = Defaults.settings_res.particle_effect
	
	
func connect_signals() -> void:
	get_viewport().connect("size_changed", Callable(self, "on_window_size_changed"))
	Defaults.connect("theme_changed", Callable(self, "on_theme_changed"))
	Defaults.connect("track_item", Callable(self, "on_track_item"))
	Defaults.connect("changed", Callable(self, "on_settings_changed"))
	


func time_track_panel_ready() -> void:
	if Defaults.settings_res.unsaved_time_track:
		await get_tree().idle_frame
		$Buttons/TimeTrackPanel.button_pressed = true



func manual_view_toggle(which : int = 0) -> void:
	which = wrapi(which, 0, number_of_views)
	buttons[which].button_pressed = true


# which passes the specific node
# idx send the id of the child. Can be used for toggling Views
func on_toggled_menu_btn(which : TextureButton, idx : int, target : String = "") -> void:
	if which != active_btn and active_btn != null:
		active_btn.deactivate()
	
	active_btn = which
	move_selection_box(which.position.y)
	emit_signal("view_changed", idx, target)


func on_window_size_changed() -> void:
	await get_tree().idle_frame
	if active_btn:
		move_selection_box(active_btn.global_position.y)


func move_selection_box(where : float = 0.0, _add_parent_y : bool = false) -> void:
	$SelectionBox/Particles.speed_scale = 1.75
	tweener.tween_property($SelectionBox, "position:y", where, 0.5)
	tweener.parallel.tween_property($SelectionBox/Particles, "speed_scale", 0.2, 0.5)


func update_theme() -> void:
	$Buttons/TimeTrackPanel.update_colours()
	$SelectionBox.color = Defaults.ui_theme.highlight_colour
	$SelectionBox/Particles.modulate = Defaults.ui_theme.highlight_colour
	if active_btn:
		active_btn.modulate = Defaults.btn_active_colour


### SIGNALS --------------

func _on_TimeTrackPanel_toggled(button_pressed: bool) -> void:
	Defaults.emit_signal("toggle_time_tracking_panel", button_pressed)


func _on_Shortcuts_shortcut_timetrack_panel() -> void:
	$Buttons/TimeTrackPanel.button_pressed = !$Buttons/TimeTrackPanel.pressed


func on_theme_changed() -> void:
	update_theme()


func on_track_item(_name : String) -> void:
	if !$Buttons/TimeTrackPanel.pressed:
		$Buttons/TimeTrackPanel.button_pressed = true


func on_settings_changed() -> void:
	update_particles()
