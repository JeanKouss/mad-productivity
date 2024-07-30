extends Label

var tweener : Tween

func _wobble(duration : float = 1.0, amount : float = 1.3) -> void:
	scale = Vector2.ONE * amount
	if tweener :
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, 'scale', Vector2.ONE, duration)
