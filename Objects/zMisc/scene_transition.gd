class_name SceneTransition

extends Node


func transition_scene(scene_path : String):

	get_tree().change_scene_to_file(scene_path)


func quit_game():

	get_tree().quit()
