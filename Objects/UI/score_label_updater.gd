extends Panel


@export_group("References")
@export var label : Label

@export var num_digits : int = 6


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var str : String = "SCORE: "

	var points = str(PointManager.points)

	for i in range(num_digits - points.length()): # Padding 0s at the front
		str += "0"

	str += points

	label.text = str

	pass # Replace with function body.
