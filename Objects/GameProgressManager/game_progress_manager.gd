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


@export_subgroup("Season")

## How many points needed to move on to first season
@export var initial_season_points : int = 25000

## How much season_points_requirement should increase by everytime season is triggered
@export var season_points_increase : int = 25000

## How much season_points_increase should increase by everytime season is triggered
@export var season_points_increase_growth : int  = 25000

@export var num_rows_to_regen_on_new_season : int = 2




#var dead_crops_stack : Array[FieldRow]
var num_dead_crops : int = 0
var last_dead_crop : FieldRow

var season_points_requirement : int


func _ready() -> void:

	PointManager.on_points_modified.connect(check_for_new_season)

	season_points_requirement = initial_season_points

	for row in field.rows:
		row.on_died.connect(_on_row_died)

	# Wait a frame to give field rows chance to initialize, then see how many started empty
	await get_tree().process_frame

	check_for_initial_empty_rows()

	pass


func _process(delta: float) -> void:
	pass


func advance_season():

	regen_rows_from_row(field.center_row, num_rows_to_regen_on_new_season)

	pass


func check_for_new_season(prev_points : int, curr_points : int):

	print(curr_points)

	if curr_points >= season_points_requirement:

		advance_season()
		season_points_requirement += season_points_increase
		season_points_increase += season_points_increase_growth

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


# If successfully regenerated full amount of num_rows_to_regen, returns 0
# Else, returns how many rows it wanted to regenerate but were left over
func regen_rows_from_row(origin_row : FieldRow, num_rows_to_regen : int) -> int:

	var left_row := origin_row
	var right_row := origin_row
	var left_to_right = false

	var first : FieldRow
	var second : FieldRow

	while (left_row != null or right_row != null) and num_rows_to_regen >= 1:

		# Alternating left to right and right to left gives us better looking row regen patterns
		# when not dealing with simple cases of rows equidistant apart
		if left_to_right:
			first = left_row
			second = right_row

		else:
			first = right_row
			second = left_row

		left_to_right = !left_to_right

		if first != null and first.dead:
			first.revive()
			num_rows_to_regen -= 1
			num_dead_crops -= 1

		if num_rows_to_regen <= 0:
			break

		if second != null and second.dead:
			second.revive()
			num_rows_to_regen -= 1
			num_dead_crops -= 1
			left_to_right = !left_to_right

		if left_row != null:
			left_row = left_row.left_neighbor_row

		if right_row != null:
			right_row = right_row.right_neighbor_row

	return num_rows_to_regen


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
