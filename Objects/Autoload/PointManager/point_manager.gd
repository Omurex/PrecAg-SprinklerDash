extends Node

signal on_points_modified(prev_points : int, curr_points : int)

@export_group("References")


@export_group("Properties")


var points : int = 0 : get = get_points,  set = set_points


func get_points() -> int:
	return points


func set_points(amount : int) -> void:
	points = amount


func modify_points(amount : int) -> int:
	var prev = points
	points += amount
	on_points_modified.emit(prev, points)
	return points


func add_points(amount : int) -> int:
	return modify_points(amount)


func subtract_points(amount : int) -> int:
	return modify_points(-amount)


func reset_points():
	points = 0
