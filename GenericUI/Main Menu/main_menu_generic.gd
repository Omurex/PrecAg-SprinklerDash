extends CanvasLayer

@export var StartScene: PackedScene
@export var CreditsScene: PackedScene
@export var HowToPlayScene: PackedScene

func _on_start_button_up():
	get_tree().change_scene_to_packed(StartScene)

func _on_how_to_play_button_up():
	get_tree().change_scene_to_packed(HowToPlayScene)

func _on_credits_button_up():
	get_tree().change_scene_to_packed(CreditsScene)
