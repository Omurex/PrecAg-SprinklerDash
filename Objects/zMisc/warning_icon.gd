class_name WarningIcon

extends CanvasItem


enum WarningIconStatus
{
	IDLE,
	LIGHT,
	HEAVY,
	UNINITIALIZED
}


@export_group("Internal References")
@export var flash_timer : Timer


@export_group("External References")
@export var field_row : FieldRow


@export_group("Properties")
@export var light_warning_color : Color = Color("fbd200")
@export var light_warning_flash_speed : float = INF
@export var heavy_warning_color : Color = Color.RED
@export var heavy_warning_flash_speed : float = .25

## How far hydration must be past healthy threshold before switching to heavy icon
## This is the portion between health bound limit and the dead limit
@export var heavy_warning_portion_threshold : float = .5

@export var light_flash_start_hidden : bool = false
@export var heavy_flash_start_hidden : bool = false


var current_status = WarningIconStatus.UNINITIALIZED


func _ready() -> void:
	update_status()


func _process(_delta: float) -> void:

	update_status()

	pass


func update_status() -> void:

	if field_row.dead:

		visible = false

		flash_timer.timeout.disconnect(_on_flash_timer_timeout)

		set_process(false)

		return

	change_status(get_status(field_row.hydration))


func change_status(new_status : WarningIconStatus):

	if current_status == new_status:
		return

	current_status = new_status

	flash_timer.stop()

	var flash_timer_delay : float = INF
	var color : Color = Color.WHITE

	match current_status:

		WarningIconStatus.IDLE:
			visible = false

		WarningIconStatus.LIGHT:
			visible = !light_flash_start_hidden
			flash_timer_delay = light_warning_flash_speed
			color = light_warning_color

		WarningIconStatus.HEAVY:
			visible = !heavy_flash_start_hidden
			flash_timer_delay = heavy_warning_flash_speed
			color = heavy_warning_color

	flash_timer.start(flash_timer_delay)
	modulate = color

	pass


func get_status(hydration_level : float) -> WarningIconStatus:

	if hydration_level > field_row.healthy_hydration_range.x \
		and hydration_level < field_row.healthy_hydration_range.y:
		return WarningIconStatus.IDLE

	var portion := 0.0

	# Plant is dehydrated
	if hydration_level <= field_row.healthy_hydration_range.x:

		portion = (hydration_level - field_row.hydration_limits.x) \
			/ (field_row.healthy_hydration_range.x - field_row.hydration_limits.x)

		portion = 1 - portion

		pass

	else: # Plant is overhydrated

		portion = (hydration_level - field_row.healthy_hydration_range.y) \
			/ (field_row.hydration_limits.y - field_row.healthy_hydration_range.y)

		pass

	if portion >= heavy_warning_portion_threshold:
		return WarningIconStatus.HEAVY

	else:
		return WarningIconStatus.LIGHT


func debug_print_status(hyd : float):

	var status = get_status(hyd)
	print(str(hyd) + " : " + WarningIconStatus.keys()[status])

	pass


func _on_flash_timer_timeout() -> void:

	visible = !visible

	pass # Replace with function body.
