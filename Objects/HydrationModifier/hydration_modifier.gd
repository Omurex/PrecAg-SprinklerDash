class_name HydrationModifier

extends Node


@export_group("References")


@export_group("Properties")
@export var mod_amount_per_sec : float = 0 :
	get:
		return mod_amount_per_sec

	set(val):
		mod_amount_per_sec = val


@export var delay : float = 0 :
	get:
		return delay

	set(val):
		delay = val


var field_row : FieldRow

var time_passed : float = 0

var paused : bool = false


func initialize(mod_amount : float, start_delay : float):

	mod_amount_per_sec = mod_amount
	delay = start_delay


func _ready() -> void:

	assert(get_parent() is FieldRow, "Hydration Modifier must be direct child of Field Row!")

	field_row = get_parent() as FieldRow

	pass


func _process(delta: float) -> void:

	time_passed += delta

	if paused or time_passed < delay:
		return

	var scale : float = 0

	if GameDifficultyScaling.instance != null:
		scale = GameDifficultyScaling.instance.hydration_modifier_scale

	field_row.modify_hydration((mod_amount_per_sec + (scale * sign(mod_amount_per_sec))) * delta)

	pass


func pause() -> void:

	toggle_pause(true)

	pass


func unpause() -> void:

	toggle_pause(false)

	pass


func toggle_pause(pause_status : bool):

	paused = pause_status

	pass


func set_delay(new_delay_time : float) -> void:

	time_passed = 0
	delay = new_delay_time

