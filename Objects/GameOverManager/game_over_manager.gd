class_name GameOverManager

extends Node


@export_group("Internal References")
@export var to_scene : PackedScene
@export var scene_transition : SceneTransition
@export var game_pause_timer : Timer


@export_group("External References")
@export var field : Field
@export var row_died_warning_ui : RowDiedWarningUI
@export var weather_system : WeatherSystem
@export var player : Player


@export_group("Properties")
@export var num_dead_rows_before_transition : int = 2


## How long the game should be essentially paused before resuming.
## Use this to allow players to read UI warning
@export var game_pause_time : float  = 5
@export var difficulty_reduction_amount_on_crop_death : float = 2


var dead_crops_stack : Array[FieldRow]


func _ready() -> void:

	for row in field.rows:
		row.on_died.connect(_on_row_died)

	pass


func check_for_scene_transition():

	if num_dead_rows_before_transition <= dead_crops_stack.size():

		scene_transition.transition_scene(to_scene.resource_path)

		pass

	pass


func pause_game() -> void:

	row_died_warning_ui.show_warning(dead_crops_stack.back().row_num, \
		dead_crops_stack.size(), num_dead_rows_before_transition)

	weather_system.stop_current_weather_effect()
	weather_system.stop_timer()

	player.lock_movement()

	for row in field.rows:

		# Give player a reset in case multiple rows were on the brink of failing
		row.initialize_hydration()
		row.sprinkler.toggle_from_row_status()

		toggle_pause_in_row_hydration_modifiers(row, true)

		row.pause_points_timer()

	pass


func unpause_game() -> void:

	row_died_warning_ui.hide_warning()

	weather_system.start_timer()

	player.unlock_movement()

	GameDifficultyScaling.instance.modify_scale(-difficulty_reduction_amount_on_crop_death)

	for row in field.rows:

		toggle_pause_in_row_hydration_modifiers(row, false)

		row.unpause_points_timer()

	check_for_scene_transition()

	pass


func toggle_pause_in_row_hydration_modifiers(row : FieldRow, status : bool):

	for child in row.get_children():

			if child is HydrationModifier:

				(child as HydrationModifier).toggle_pause(status)


func _on_row_died(field_row : FieldRow):

	dead_crops_stack.push_back(field_row)

	pause_game()

	game_pause_timer.start(game_pause_time)

	pass


func _on_game_pause_timer_timeout() -> void:

	unpause_game()

	pass # Replace with function body.
