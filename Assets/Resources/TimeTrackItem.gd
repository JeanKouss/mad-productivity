extends Resource

class_name TimeTrackItem

@export var date_ranges: Array
@export var name: String
@export var type: int

func create_track(n : String) -> void:
	name = n
	date_ranges = []

func start_tracking(_start : int) -> void:
	date_ranges += [[_start]]

func end_tracking(end : int) -> void:
	print(date_ranges)
	date_ranges[-1] += [end]

func get_start_unix_time() -> int:
	return date_ranges[0][0]

func get_duration() -> int:
	var length : int = 0
	for daterange in date_ranges:
		if len(daterange) > 1:
			length += (daterange[1] - daterange[0])
		else:
			length += (Time.get_unix_time_from_system() - daterange[0])
	return length

func get_length(only_last : bool = false) -> int:
	var length : int = 0
	if only_last:
		length = date_ranges[-1][1] - date_ranges[-1][0]
	else:
		for datarange in date_ranges:
			if len(datarange) > 1:
				length += (datarange[1] - datarange[0])
	return length


func is_finished() -> bool:
	return len(date_ranges[-1]) == 2

