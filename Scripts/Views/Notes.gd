extends Control

@export var title : String
var active_note : NoteResource
var active_btn : Button

var resource_file_paths : Array

var notes_no : int = 0


func _ready() -> void:
	$VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons/DefaultButton.hide()
	reset_state()
	load_notes()
	
	
func load_notes() -> void:
	var dir : DirAccess = DirAccess.open(Defaults.NOTES_SAVE_PATH)

	if dir :
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				resource_file_paths.append(file_name)
			file_name = dir.get_next()
			
	resource_file_paths.sort()
	for i in resource_file_paths:
		add_button_from_resource(load(Defaults.NOTES_SAVE_PATH + i))
		notes_no += 1
	
#	if resource_file_paths.size() > 0:
#		select_note(1)
	
	
func select_note(which : int) -> void:
	var button : Button = $VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons.get_child(which)
	button.button_pressed = true
	_on_note_btn_clicked(button.res, button)
	
	
	
func entering_view() -> void:
	Defaults.active_view_pointer = self
	Defaults.emit_signal("view_changed", title, true, false)
	update_text_edit()
	update_view_text()
	
	
func leaving_view() -> void:
	save()
	
	
func save() -> void:
	Defaults.save_note_resource(active_note)
	
	
func add_button() -> void:
	var new_btn : Button = $VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons/DefaultButton.duplicate()
	new_btn.visible = true
	var res : NoteResource = NoteResource.new()
	res.title = "New note"
	res.text = "Put text here"
	res.date_created = Time.get_datetime_dict_from_system()
	res.date_modified = Time.get_datetime_dict_from_system()
	res.save_name = Defaults.get_date_and_time_with_underscores({}) + "_Note" + str(randi() % 256)
	new_btn.res = res
	new_btn.text = res.title
	active_note = res
	
	new_btn.connect("button_down", Callable(self, "_on_note_btn_clicked").bind(res, new_btn))
	new_btn.connect("start_time_track", Callable(self, "_on_start_time_track"))
	new_btn.connect("note_delete_pressed", Callable(self, "_on_note_btn_delete_clicked"))
	$VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons.add_child(new_btn)
	new_btn.grab_click_focus()
	
	notes_no += 1
	update_view_text()


func reset_state() -> void:
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Title.text = ""
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Note.text = ""
	active_note = null
	active_btn = null


func update_text_edit() -> void:
	var res: SettingsResource = Defaults.settings_res
	var te : TextEdit = $VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Note
	te.minimap_draw = res.minimap
	te.highlight_current_line = res.highlight_current_line
	te.draw_tabs = res.draw_tabs
	te.draw_spaces = res.draw_spaces
	te.highlight_all_occurrences = res.highlight_all_occurances
	te.syntax_highlighter = SyntaxHighlighter.new() if res.syntax_highlighting else null
	te.show_line_numbers = res.line_numbers


func add_button_from_resource(res : NoteResource) -> void:
	var new_btn : Button = $VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons/DefaultButton.duplicate()
	new_btn.visible = true
	res.date_modified = Time.get_datetime_dict_from_system()
	new_btn.res = res
	new_btn.text = res.title
	active_note = res
	
	new_btn.connect("button_down", Callable(self, "_on_note_btn_clicked").bind(res, new_btn))
	new_btn.connect("start_time_track", Callable(self, "_on_start_time_track"))
	new_btn.connect("note_delete_pressed", Callable(self, "_on_note_btn_delete_clicked"))
	$VBoxContainer/HSplitContainer/Panel/ScrollContainer/NoteButtons.add_child(new_btn)
	new_btn.grab_click_focus()


func update_view_text() -> void:
	var text : String = ""
	text = "Notes: " + str(notes_no)
	Defaults.emit_signal("update_view_info", text)


## SIGNALS


func _on_Title_text_changed() -> void:
	if !active_btn: return
	var _text : String = $VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Title.text
	active_btn.text = _text
	active_note.title = _text


func _on_Note_text_changed() -> void:
	if !active_btn: return
	active_note.text = $VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Note.text


func _on_click_add_button() -> void:
	$VBoxContainer/Title._wobble()
	add_button()
	
	
func _on_note_btn_clicked(_note : NoteResource, _btn : Button) -> void:
	# saves the previously active note
	if !_btn.deleting:
		if active_note:
			active_note.date_modified = Time.get_datetime_dict_from_system()
		save()
	
	if _btn.deleting:
		reset_state()
		return
	# set the new active note
	active_note = _note
	active_btn = _btn
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Title.text = active_note.title
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/Note.text = active_note.text
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/HBoxContainer/Created.text = Defaults.get_date_with_time_string(_note.date_created)
	$VBoxContainer/HSplitContainer/Panel2/VBoxContainer/HBoxContainer/Modified.text = Defaults.get_date_with_time_string(_note.date_modified)


func _on_start_time_track(_name) -> void:
	print("carrying on")
	get_parent().start_custom_time_track(_name)


func on_new_top_bar_button(message : Dictionary = {}) -> void:
	add_button()


func _on_note_btn_delete_clicked(btn : Button, res : NoteResource) -> void:
	notes_no -= 1
	update_view_text()
	reset_state()
