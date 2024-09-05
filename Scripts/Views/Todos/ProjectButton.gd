extends Button

signal selected_project(_name, index, child_index)
signal delete_project(id)

var id : int
var finished : bool = false

var tweener : Tween

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	on_mouse_exited()
	update_theme()
	
	
func update_theme() -> void:
#	$CompleteBG/CompleteBar.color = Defaults.ui_theme.highlight_colour
	pass
	
	
func on_mouse_entered() -> void:
	$TimeTrack.show()
	$DeleteBtn.show()
	
	
func on_mouse_exited() -> void:
	$TimeTrack.hide()
	$DeleteBtn.hide()
	

func _on_ProjectButton_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		selected_project.emit(text, id, get_index())


func _on_DeleteBtn_pressed() -> void:
	delete_project.emit(id)
	queue_free()

func set_percent_done(perc : float = 0.0) -> void:
	finished = bool(floor(perc))
	if tweener :
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property($CompleteBG/CompleteBar, "scale:x", perc, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tweener.parallel().tween_property($CompleteBG/CompleteBar, "modulate:a", perc, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
#	$CompleteBG/CompleteBar.rect_scale.x = clamp(perc, 0.0, 1.0)


func on_tween_done() -> void: # Previously emited when tween completed
	if finished:
#		$CompleteSound.play()
		pass


func _on_TimeTrack_pressed() -> void:
	Defaults.emit_signal("track_item", text)
