extends CanvasLayer
class_name Main

signal cur_view_changed(from:String, to:String)
signal time_tracking_panel_toggle(active:bool)

@onready var sidebar := $HBoxContainer/Sidebar
@onready var time_tracking := $HBoxContainer/TimeTrackingPanel

func _ready() -> void:
	_connect_sidebar_signals()

func _connect_sidebar_signals() :
	sidebar.time_tracking_requested.connect(toggle_time_tracking)


func toggle_time_tracking() :
	if time_tracking.is_shown() :
		time_tracking.hide_panel()
		time_tracking_panel_toggle.emit(false)
	else : 
		time_tracking.show_panel()
		time_tracking_panel_toggle.emit(true)
