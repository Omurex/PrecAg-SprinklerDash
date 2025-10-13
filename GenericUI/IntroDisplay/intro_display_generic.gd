extends CanvasLayer

@export var Displays: Array[Control]
@export var NextButton: Button
@export var BackButton: Button
@export var StartScene: PackedScene
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NextButton.connect("button_up", OnNextUp)
	BackButton.connect("button_up", OnBackUp)
	if counter == len(Displays) -1:
			NextButton.text = "Start!"

func OnNextUp():
	if counter < len(Displays) -1:
		if counter == 0:
			BackButton.disabled = false
		Displays[counter].visible = false
		counter += 1
		Displays[counter].visible = true
		if counter == len(Displays) -1:
			NextButton.text = "Start!"
		return
	get_tree().change_scene_to_packed(StartScene)
	
func OnBackUp():
	if counter > 0:
		Displays[counter].visible = false
		counter -= 1
		Displays[counter].visible = true
		if counter == 0:
			BackButton.disabled = true
		if NextButton.text == "Start!":
			NextButton.text = "Next"
		return
