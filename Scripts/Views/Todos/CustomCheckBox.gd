extends Panel

signal set_done(really)

var pressed : bool: set = set_pressed

var tweener = create_tween()

func set_pressed(new : bool) -> void:
#	color = Defaults.custom_check_box_inactive
	if new:
		call_deferred("animate_checkbox", 0.0, 1.0)
#		animate_checkbox(0.0, 1.0)
#		color = Defaults.custom_check_box_active
	else:
		call_deferred("animate_checkbox", 1.0, 0.0)
#		animate_checkbox(1.0, 0.0)
	pressed = new
	emit_signal("set_done", new)


func animate_checkbox(start : float, end : float) -> void:
	$Tween.remove_all()
	$Tween.interpolate_property($CheckBox2, "rotation", $CheckBox2.rotation, 360 * end, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0.0)
	$Tween.interpolate_property($CheckBox2, "scale", $CheckBox2.scale, Vector2.ONE * end, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0.0)
	$Tween.start()
	$CheckBox2.visible = true
#	$CheckBox2.visible = bool(floor(end))



func _on_CheckBox_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		self.button_pressed = !self.pressed
