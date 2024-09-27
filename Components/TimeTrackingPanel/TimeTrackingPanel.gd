extends Panel

@onready var normal_tab_button := $TabContainer/TabHead/NormalTabButton
@onready var normal_tab := $TabContainer/TabBody/NormalTimeTracking
@onready var pomodoro_tab_button := $TabContainer/TabHead/PomodoroTabButton
@onready var pomodoro_tab := $TabContainer/TabBody/PomodoroTimeTracking


var visibility_tweener : Tween
var showing := false

func _ready() -> void:
	hide_panel()
	_on_normal_tab_button_down()


func is_shown() :
	return showing


func show_panel() :
	if visibility_tweener :
		visibility_tweener.kill()
	visibility_tweener = create_tween()
	visibility_tweener.tween_property(self, 'size:x', 250, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	showing = true


func hide_panel() :
	if visibility_tweener :
		visibility_tweener.kill()
	visibility_tweener = create_tween()
	visibility_tweener.tween_property(self, 'size:x', 0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	showing = false


func _on_pomodoro_tab_button_down() -> void:
	if normal_tab.is_timer_active :
		return
	pomodoro_tab_button.theme_type_variation = 'TabButtonActive'
	normal_tab_button.theme_type_variation = 'TabButton'
	pomodoro_tab.visible = true
	normal_tab.visible = false
	

func _on_normal_tab_button_down() -> void:
	if pomodoro_tab.is_timer_active :
		return
	normal_tab_button.theme_type_variation = 'TabButtonActive'
	pomodoro_tab_button.theme_type_variation = 'TabButton'
	normal_tab.visible = true
	pomodoro_tab.visible = false
	
