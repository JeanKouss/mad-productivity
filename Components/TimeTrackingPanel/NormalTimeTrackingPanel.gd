extends Control

@onready var start_button = %StartButton
@onready var pause_button = %PauseButton
@onready var finish_button = %FinishButton
@onready var cancel_button = %CancelButton
@onready var item_input = %ItemInput


func _ready() -> void:
	init_component()
	pass

func init_component() :
	start_button.visible = true
	pause_button.visible = false
	finish_button.visible = false
	cancel_button.visible = false
	item_input.visible = true

func start_timer() :
	pause_button.text = 'Pause'
	start_button.visible = false
	pause_button.visible = true
	finish_button.visible = true
	cancel_button.visible = true
	pass

func pause_timer() :
	pause_button.text = 'Continue'

func finish_timer() :
	pause_button.text = 'Pause'
	start_button.visible = true
	pause_button.visible = false
	finish_button.visible = false
	cancel_button.visible = false

func cancel_timer() :
	pause_button.text = 'Pause'
	start_button.visible = true
	pause_button.visible = false
	finish_button.visible = false
	cancel_button.visible = false


func _on_start_button_pressed() -> void:
	start_timer()
	pass

func _on_pause_button_pressed() -> void:
	pause_timer()
	pass

func _on_finish_button_pressed() -> void:
	finish_timer()
	pass

func _on_cancel_button_pressed() -> void:
	cancel_timer()
	pass
