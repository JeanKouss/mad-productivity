extends ColorRect

signal new_tracked_item_text(new_text, id)
signal delete_pressed(idx)

var id : int

var highlight_color : Color
var idle_color : Color

var tweener : Tween

func _ready() -> void:
	idle_color = Color(1, 1, 1, 0)
	highlight_color = Defaults.ui_theme.super_dark
	color = idle_color


func fill_details(date : String, time : String, _name : String) -> void:
	$H/Date.text = date
	$H/TrackedTime.text = time
	$H/ProjectName.text = _name
	

func show_up() -> void:
	$H/Delete.hide()
	$H/TimeTrack.hide()
	modulate.a = 0.0
	if tweener :
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "modulate:a", 1.0, 1.0)


func _on_TrackedItem_mouse_entered() -> void:
	color = highlight_color
	$H/TimeTrack.show()
	$H/Delete.show()


func _on_TrackedItem_mouse_exited() -> void:
	color = idle_color
	$H/TimeTrack.hide()
	$H/Delete.hide()


func _on_Delete_button_up() -> void:
	emit_signal("delete_pressed", id)
	queue_free()


func _on_TimeTrack_button_up() -> void:
	Defaults.emit_signal("track_item", $H/ProjectName.text)


func _on_ProjectName_text_changed(new_text: String) -> void:
	emit_signal("new_tracked_item_text", new_text, id)
