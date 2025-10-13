extends CanvasLayer

@export var Displays: Array[Control]
@export var NextButton: Button
@export var BackButton: Button
@export var MainMenuButton: Button
@export var MenuScene: PackedScene
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NextButton.connect("button_up", OnNextUp)
	BackButton.connect("button_up", OnBackUp)
	MainMenuButton.connect("button_up", OnMenuUp)
	if counter == len(Displays) -1:
			NextButton.disabled = true


func OnNextUp():
	if counter < len(Displays) -1:
		if counter == 0:
			BackButton.disabled = false
		Displays[counter].visible = false
		counter += 1
		Displays[counter].visible = true
		if counter == len(Displays) -1:
			NextButton.disabled = true
		return

	
func OnBackUp():
	if counter > 0:
		if counter == len(Displays) -1:
			NextButton.disabled = false
		Displays[counter].visible = false
		counter -= 1
		Displays[counter].visible = true
		if counter == 0:
			BackButton.disabled = true
		return

func OnMenuUp():
	get_tree().change_scene_to_packed(MenuScene)
