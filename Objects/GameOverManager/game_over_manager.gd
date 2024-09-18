class_name GameOverManager

extends Node


@export_group("Internal References")
@export var scene_transition : SceneTransition


@export_group("External References")
@export var to_scene : PackedScene
@export var field : Field
@export var row_died_warning_ui : RowDiedWarningUI


@export_group("Properties")
@export var num_dead_rows_before_transition : int = 2

## How long players should get a break from hydration modifiers
@export var after_died_buffer_time : float = 3

## How long the game should be essentially paused before resuming
## Use this to allow players to read UI warning
@export var game_pause_time : float  = 5


var num_died : int = 0


func _ready() -> void:

	for row in field.rows:
		row.on_died.connect(_on_row_died)

	pass


func check_for_scene_transition():

	if num_dead_rows_before_transition <= num_died:

		scene_transition.transition_scene(to_scene.resource_path)

		pass

	pass


func _on_row_died(field_row : FieldRow):

	num_died += 1

	row_died_warning_ui.show_warning(field_row.row_num, num_died, \
		num_dead_rows_before_transition)

	pass
