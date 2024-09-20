extends TextureButton
class_name SidebarButton

var active := false :
	set(value) :
		active = value
		if active :
			activate()
		else :
			deactivate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_connect_signals()

func _connect_signals() :
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func highlight() :
	modulate = AppTheme.get_color('highlight')

func unhighlight() : # Should be added to english dictonary 🙂
	modulate = Color('#fff')

func activate() :
	modulate = AppTheme.get_color('button_active')

func deactivate() :
	modulate = Color('#fff')

func _on_mouse_entered() :
	highlight()
	
func _on_mouse_exited() :
	unhighlight()
	