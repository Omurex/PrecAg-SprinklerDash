class_name MusicPlayerNotifier

extends Node


@export_group("Internal References")


@export_group("External References")
@export var audio : AudioStream


@export_group("Properties")


func _ready() -> void:

	MusicPlayer.play_or_continue(audio)

	pass

