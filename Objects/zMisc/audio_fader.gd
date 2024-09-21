class_name AudioFader

extends AudioStreamPlayer


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")


var fade_time : float
var fade_mult : int
var time_passed := 0.0
var fading := false
var start_volume


func _process(delta: float) -> void:

	if fading:
		time_passed += delta


func start_fade(fade_end_volume : float, \
	time_to_fade : float, fade_in : bool):

	time_passed = 0

	fade_mult = int(fade_in)

	pass


func start_fade_in

