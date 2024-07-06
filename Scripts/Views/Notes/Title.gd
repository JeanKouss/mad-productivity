extends Label

var tweener = create_tween()

func _wobble(duration : float = 1.0, amount : float = 1.3) -> void:
	scale = Vector2.ONE * amount
	tweener.tween_property(self, 'scale', Vector2.ONE, duration)
