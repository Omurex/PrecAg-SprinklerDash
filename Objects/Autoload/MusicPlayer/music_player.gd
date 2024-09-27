extends AudioStreamPlayer


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")



func play_or_continue(audio : AudioStream):

	if stream != audio:

		stream = audio

	if playing == false:
		playing = true

	stream_paused = false


