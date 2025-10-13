extends CanvasLayer

@export var MenuScene: PackedScene

func OnMenuUp():
	get_tree().change_scene_to_packed(MenuScene)
