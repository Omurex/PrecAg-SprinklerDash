extends CanvasLayer

# Unlike the main and final menus, this one should have its
# next scene dictated by an autoload, as it will change regularly.
var NextScene: PackedScene
	
func _on_continue_button_up():
	get_tree().change_scene_to_packed(NextScene)
