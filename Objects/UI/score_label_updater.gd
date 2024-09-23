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

	update_label()

	set_process(update_every_frame)

	pass # Replace with function body.


func _process(_delta: float) -> void:

	# Should really be tied to an event, but doesn't matter too much
	update_label()



func update_label() -> void:

	var label_text : String = preceding_line

	var points = str(PointManager.points)

	for i in range(num_digits - points.length()): # Padding 0s at the front
		label_text += "0"

	label_text += points

	label_text += proceding_line

	label.text = label_text.c_unescape()

	pass
