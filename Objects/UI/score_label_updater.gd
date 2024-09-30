extends Node


@export_group("References")
@export var label : Label

@export_group("Properties")
@export var preceding_line : String = "SCORE: "
@export var proceding_line : String = ""
@export var num_digits : int = 6
@export var update_every_frame : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	update_label(-1, PointManager.points)

	PointManager.on_points_modified.connect(update_label)

	set_process(update_every_frame)

	pass # Replace with function body.



func update_label(prev_points : int, curr_points : int) -> void:

	var label_text : String = preceding_line

	var points = Format.format_points_to_default(curr_points)


	#for i in range(num_digits - points.length()): # Padding 0s at the front
		#label_text += "0"

	#var num_zeros = 3 - (points_initial_len % 3)
	#if num_zeros == 3:
		#num_zeros = 0
#
	#print(num_zeros)
	#for i in range(num_zeros):
		#label_text += "0"

	label_text += points

	label_text += proceding_line

	label.text = label_text.c_unescape()

	pass
