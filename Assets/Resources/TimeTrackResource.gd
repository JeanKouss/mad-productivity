class_name TimeTrackResource
extends Resource

@export var project: String
@export var time_tracked: int
@export var save_name: String
@export var date_modified: Dictionary
@export var date_created: Dictionary
@export var tracks: Dictionary
@export var pomodoro_on: bool
@export var tracks_count: int
@export var track_back_up: Dictionary

func add_track(name : String) -> int:
	var item = TimeTrackItem.new()
	item.create_track(name)
	tracks_count += 1
	tracks[tracks_count] = item
	return tracks_count


func add_finished_track(item : TimeTrackItem) -> int:
	tracks_count += 1
	tracks[tracks_count] = item
	return tracks_count


func get_track(_id : int) -> TimeTrackItem:
	if tracks.has(_id):
		return tracks[_id]
	else:
		return TimeTrackItem.new()

#func get_track_length(id : int) -> Dictionary:
	#if id < 0:
		##id = tracks.length() -1

