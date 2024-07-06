extends Button

signal note_delete_pressed(btn, res)
signal start_time_track(_name)

var res : NoteResource
var deleting = false

@export var delete_btn_colour: Color
var target_opacity : float

var tweener = create_tween()

func _ready() -> void:
#	$DeleteBtn.modulate = delete_btn_colour
#	$DeleteBtn.modulate.a = 1.0
	target_opacity = $DeleteBtn.modulate.a
	$DeleteBtn.hide()
	$TimeTrack.hide()
	$DeleteBtn.connect("button_up", Callable(self, "_on_delete_btn_pressed"))
	$TimeTrack.connect("button_up", Callable(self, "_on_time_track_btn_pressed"))
	connect("mouse_entered", Callable(self, "mouse_entered"))
	connect("mouse_exited", Callable(self, "mouse_exited"))
	
	
func hide_delete(duration : float = 0.5) -> void:
	# IMPORTANT : tween.remove_all() is the way to reset and stop all animation so that they cant overlap
	tweener.stop()
	scale = Vector2.ONE
	tweener.tween_property($DeleteBtn, 'scale', Vector2.ONE * 0.01, duration)
	tweener.parallel().tween_property($DeleteBtn, 'modulate:a', 0.0, duration)
	
func show_delete(duration : float = 0.5) -> void:
	tweener.stop()
	scale = Vector2.ONE * 0.01
	tweener.tween_property($DeleteBtn, 'scale', Vector2.ONE, duration)
	tweener.parallel().tween_property($DeleteBtn, 'modulate:a', target_opacity, duration)
	
	
func mouse_entered() -> void:
#	show_delete()
	$DeleteBtn.show()
	$TimeTrack.show()
	
func mouse_exited() -> void:
#	hide_delete()
	$DeleteBtn.hide()
	$TimeTrack.hide()
	
	
func _on_delete_btn_pressed() -> void:
	emit_signal("note_delete_pressed", self, res)
	delete_note(self, res)
		
		
func _on_time_track_btn_pressed() -> void:
	Defaults.emit_signal("track_item", res.title)
		
		
func delete_note(_btn : Button, _res : NoteResource) -> void:
	deleting = true
	var dir : DirAccess = DirAccess.open("user://")
	var _err = dir.remove(Defaults.NOTES_SAVE_PATH + _res.save_name + ".tres")
	queue_free()
	
