extends Panel

var visibility_tweener : Tween
var showing := false

func _ready() -> void:
	hide_panel()

func is_shown() :
	return showing

func show_panel() :
	if visibility_tweener :
		visibility_tweener.kill()
	visibility_tweener = create_tween()
	visibility_tweener.tween_property(self, 'size:x', 300, 0.2)
	showing = true

func hide_panel() :
	if visibility_tweener :
		visibility_tweener.kill()
	visibility_tweener = create_tween()
	visibility_tweener.tween_property(self, 'size:x', 0, 0.2)
	showing = false