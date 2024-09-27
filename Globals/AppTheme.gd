extends Node

var current_theme := 'dark'

const palettes = {
	'dark' : {
		'highlight' : Color( 0.729412, 0.87451, 0.2, 1 ),
		'primary' : Color( 0.156863, 0.156863, 0.156863, 1 ),
		'button_inactive' : Color( 1, 1, 1, 0.435294 ),
		'text_color' : Color( 0.85098, 0.85098, 0.85098, 1 ),
		# 'background1' : Color( 0.85098, 0.85098, 0.85098, 1 ),
		# 'background2' : Color( 0.85098, 0.85098, 0.85098, 1 ),
		# 'background3' : Color( 0.85098, 0.85098, 0.85098, 1 ),
	},
}

func get_color(role:String) :
	return  palettes[current_theme].get(role, Color('#fff'))
