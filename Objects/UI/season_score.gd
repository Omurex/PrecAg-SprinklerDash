extends Control


@export_group("Internal References")
@export var label : Label
@export var flash_length_timer : Timer
@export var flash_delay_timer : Timer


@export_group("External References")
@export var game_progress_manager : GameProgressManager


@export_group("Properties")
@export var next_season_threshold_preceding_text : String
@export var new_season_reached_text : String
@export var new_season_reached_flash_delay : float = .5
@export var new_season_reached_flash_time : float = 5



func _ready() -> void:

	game_progress_manager.on_new_season.connect(update_season_ui)
	update_label()

	pass


func update_season_ui(prev_threshold : int, curr_threshold : int):

	label.text = (new_season_reached_text).c_unescape()

	flash_length_timer.start(new_season_reached_flash_time)
	flash_delay_timer.start(new_season_reached_flash_delay)

	pass


func update_label() -> void:

	label.text = (next_season_threshold_preceding_text + Format.format_points_to_default(game_progress_manager.season_points_requirement)).c_unescape()


func _on_flash_length_timer_timeout() -> void:

	flash_delay_timer.stop()

	update_label()

	visible = true

	pass # Replace with function body.


func _on_flash_delay_timer_timeout() -> void:

	visible = !visible

	pass # Replace with function body.
