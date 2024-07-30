extends Label

@export var resource: Resource

var tweener : Tween

var texts : Array
var quote_index : int
func _ready() -> void:
	texts = Defaults.settings_res.quote_list.values()
	load_new_text(get_random_index())

func load_new_text(index: int) -> void:
	modulate.a = 0.0
	quote_index += index
	show_new_text(texts[quote_index % texts.size()])

func _on_Next_pressed() -> void:
	load_new_text(1)
func _on_Previous_pressed() -> void:
	load_new_text(-1)

func show_new_text(quote_text) -> void:
	text = "\"" + quote_text +  "\""
	if tweener :
		tweener.kill()
	tweener = create_tween()
	self.modulate.a = 0.0
	self.visible_ratio = 0.0
	tweener.tween_property(self, "modulate:a", 1.0, 3.0)
	tweener.parallel().tween_property(self, "percent_visible", 1.0, 2.0)

func get_random_index() -> int:
	return randi()%texts.size()
