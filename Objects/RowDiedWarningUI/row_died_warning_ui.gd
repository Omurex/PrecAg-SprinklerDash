class_name RowDiedWarningUI

extends Control


@export_group("Internal References")
@export var label : Label


@export_group("External References")


@export_group("Properties")



func _ready() -> void:
	visible = false
	pass


func show_warning(row_num_that_died : int, current_num_dead : int, max_dead : int) -> void:

	visible = true

	var num_left := max_dead - current_num_dead

	var str := "ROW " + str(row_num_that_died) + "'S CROPS HAVE DIED.\n"

	if num_left == 0:

		str += "GAME OVER."

	else:

		str += str(num_left) + " CROP"

		if num_left != 1:
			str += "S"

		str += " LEFT BEFORE GAME OVER!"

	label.text = str.c_unescape()

	pass


func hide_warning() -> void:
	visible = false
	pass

