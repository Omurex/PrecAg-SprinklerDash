class_name GameTimer

extends Timer


@export_group("Internal References")
@export var scene_transition : SceneTransition


@export_group("External References")
@export var to_scene : PackedScene


@export_group("Properties")


func _on_timeout() -> void:

	scene_transition.transition_scene(to_scene.resource_path)

	pass # Replace with function body.
