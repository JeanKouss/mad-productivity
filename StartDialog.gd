extends Control

func _ready() -> void:
	if OS.get_name() == "X11" or OS.get_name() == "Server":
		get_window().borderless = (false)
	else:
		get_window().borderless = (true)
	get_tree().call_deferred('change_scene_to_file', "res://Main.tscn")
