extends Resource
class_name ThemeResource

@export var primary_col: Color
@export var highlight_colour: Color
@export var contrast: float 

# Button specific

@export var btn_active_col : Color
@export var btn_inactive_col : Color

# Fonts
@export var text_color: Color


# private vars calculated based on the contrast value
var normal : Color
var darker : Color
var super_dark : Color
var lighter : Color
var highlight_lighter : Color
var highlight_darker : Color

func update_theme_values() -> void:
	# btn defaults
	btn_inactive_col = Color(1, 1, 1, 0.396078)
	btn_active_col = highlight_colour
	
	#update the defaults
	Defaults.btn_active_colour = btn_active_col
	Defaults.btn_inactive_colour = btn_inactive_col
	
	# maths!
	normal = primary_col
	darker = primary_col.lerp(Color.BLACK, contrast)
	super_dark = primary_col.lerp(Color.BLACK, contrast * 2.0)
	lighter = primary_col.lerp(Color.WHITE, contrast * 0.5)
	
	highlight_lighter = highlight_colour.lerp(Color.WHITE, contrast)
	highlight_darker = highlight_colour.lerp(Color.BLACK, contrast)


func get_color(which : int) -> Color:
	match which:
		0:
			# primary
			return primary_col
		1:
			# highlight
			return highlight_colour
		2:
			# text color
			return text_color
		_: 
			return primary_col

func set_color(which : int, new : Color) -> void:
	match which:
		0:
			# primary
			primary_col = new
		1:
			# highlight
			highlight_colour = new
		2:
			# text color
			text_color = new

	Defaults.update_theme()
#	Defaults.emit_signal("theme_changed")


func save_theme() -> void:
	ResourceSaver.save(self, Defaults.settings_res.THEME_SAVE_PATH)
