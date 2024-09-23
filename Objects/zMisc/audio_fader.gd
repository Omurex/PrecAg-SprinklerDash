class_name AudioFader

extends AudioStreamPlayer


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")


var fade_time : float
var start_volume : float
var end_volume : float

var fading := false
var time_passed := 0.0


func _process(delta: float) -> void:

	if fading:

		time_passed += delta

		if time_passed >= fade_time:
			fading = false
			time_passed = fade_time

		volume_db = lerpf(start_volume, end_volume, time_passed / fade_time)


func start_fade(fade_time_duration : float, \
	fade_start_volume : float, fade_end_volume : float):

	fading = true
	time_passed = 0
	start_volume = fade_start_volume
	end_volume = fade_end_volume
	fade_time = fade_time_duration

	pass


func resume_fade():

	fading = true


func pause_fade():

	fading = false




