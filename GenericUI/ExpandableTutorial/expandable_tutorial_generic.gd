extends Panel

@export_group("Children")
@export var CloseButton: Button

@export_group("Interconnectivity")
@export var OpenButton: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OpenButton.connect("button_up", Open)
	CloseButton.connect("button_up", Close)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Open():
	visible = true
	
func Close():
	visible = false
