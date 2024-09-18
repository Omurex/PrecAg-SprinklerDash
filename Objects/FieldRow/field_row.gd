class_name FieldRow

extends Node2D


signal on_died(field_row : FieldRow)


@export_group("References")
@export var points_timer : Timer
@export var tilemap : TileMap
@export var sprinkler : Sprinkler


@export_group("Properties")
@export var field_row_coloring_data : Array[FieldRowColoringData]
@export var hydration_limits = Vector2(0, 100)
@export var healthy_hydration_range = Vector2(25, 75)
@export var hydration_start_range = Vector2(25, 75)
@export var points_per_timer : int = 5
@export var row_num : int = -1

var healthy : bool = true
var dead : bool = false

var current_layer_hydration_range : Vector2 = Vector2(INF, -INF)
var current_enabled_layer : int = 0


var hydration : float = 0 :
	get = get_hydration, set = set_hydration


func get_hydration() -> float:

	return hydration


func set_hydration(val) -> void:

	if dead:
		return

	hydration = val

	healthy = hydration >= healthy_hydration_range.x and hydration <= healthy_hydration_range.y
	dead = hydration < hydration_limits.x or hydration > hydration_limits.y

	points_timer.paused = !healthy

	if dead:
		set_process(false)
		check_for_tilemap_update()
		on_died.emit(self)


func _enter_tree() -> void:

	hydration = Random.randf_range_vec2(healthy_hydration_range)

	pass


func _ready() -> void:

	# Turn off all tilemap layers to start
	for i in range(tilemap.get_layers_count()):
		tilemap.set_layer_enabled(i, false)

	check_for_tilemap_update()

	pass


func _process(_delta: float) -> void:

	check_for_tilemap_update()

	pass


func check_for_tilemap_update() -> void:

	if hydration >= current_layer_hydration_range.x \
		and hydration <= current_layer_hydration_range.y:

		return

	for i in range(field_row_coloring_data.size()):

		var data = field_row_coloring_data[i]

		if hydration <= data.threshold:

			# Update hydration range
			if i == 0:
				current_layer_hydration_range.x = -INF
				current_layer_hydration_range.y = data.threshold

			elif i == field_row_coloring_data.size() - 1:
				current_layer_hydration_range.x = data.threshold
				current_layer_hydration_range.y = INF

			else:
				current_layer_hydration_range.x = field_row_coloring_data[i - 1].threshold
				current_layer_hydration_range.y = data.threshold

				pass

			tilemap.set_layer_enabled(current_enabled_layer, false)
			tilemap.set_layer_enabled(data.layer, true)

			current_enabled_layer = data.layer

			return

	assert(0 == 1, "If here, something is messed up with thresholds / layering for soil hydration")

	pass



func modify_hydration(modification) -> void:

	hydration += modification


func _on_points_timer_timeout() -> void:

	PointManager.add_points(points_per_timer)

	pass # Replace with function body.
