class_name GameOverManager

extends Node


@export_group("Internal References")
@export var to_scene : PackedScene
@export var scene_transition : SceneTransition
@export var game_pause_timer : Timer


@export_group("External References")
@export var field : Field
@export var center_row : FieldRow
@export var row_died_warning_ui : RowDiedWarningUI
@export var weather_system : WeatherSystem
@export var player : Player


@export_group("Properties")
@export var num_dead_rows_before_transition : int = 2


## How long the game should be essentially paused before resuming.
## Use this to allow players to read UI warning
@export var game_pause_time : float  = 5
@export var difficulty_reduction_amount_on_crop_death : float = 2


#var dead_crops_stack : Array[FieldRow]
var num_dead_crops : int = 0
var last_dead_crop : FieldRow


func _ready() -> void:

	for row in field.rows:
		row.on_died.connect(_on_row_died)

	# Wait a frame to give field rows chance to initialize, then see how many started empty
	await get_tree().process_frame



	pass


func check_for_initial_empty_rows() -> void:

	for row in field.rows:

		if row.dead:

			num_dead_crops += 1


func check_for_scene_transition():

	if num_dead_rows_before_transition <= num_dead_crops:

		scene_transition.transition_scene(to_scene.resource_path)

		pass

	pass


func pause_game() -> void:

	row_died_warning_ui.show_warning(last_dead_crop.row_num, \
		num_dead_crops, num_dead_rows_before_transition)

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


func regen_rows_from_row(origin_row : FieldRow, num_rows_to_regen : int):

	#if origin_row.dead

	pass


func _on_row_died(field_row : FieldRow):

	num_dead_crops += 1
	last_dead_crop = field_row

	pause_game()

	game_pause_timer.start(game_pause_time)

	pass


func _on_row_revived(field_row : FieldRow):
	pass


func _on_game_pause_timer_timeout() -> void:

	unpause_game()

	pass # Replace with function body.
