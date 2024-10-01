class_name FieldRow

extends Node2D


signal on_died(field_row : FieldRow)
signal on_revive(field_row : FieldRow)


@export_group("References")
@export var points_timer : Timer
@export var tilemap : TileMap
@export var sprinkler : Sprinkler

@export var tomato_sprites_container : Node2D
@export var sprinkler_nozzles_container : Node2D
@export var warnings : Node2D

@export var overhydrate_tex : Texture2D
@export var base_tomato_tex : Texture2D
@export var underhydrate_tex : Texture2D

@export var left_neighbor_row : FieldRow
@export var right_neighbor_row : FieldRow


@export_group("Properties")
@export var field_row_coloring_data : Array[FieldRowColoringData]
@export var hydration_limits = Vector2(0, 100)
@export var healthy_hydration_range = Vector2(25, 75)
@export var hydration_start_range = Vector2(25, 75)
@export var row_num : int = -1

@export_subgroup("Points")
@export var points_per_timer : int = 5
@export var min_difficulty : float = 1
@export var max_difficulty : float = 20
@export var min_difficulty_point_timer_delay : float = 1
@export var max_difficulty_point_timer_delay : float = .1

@export_group("Empty Row Initialization")
@export var start_empty : bool = false
@export var empty_field_row_coloring_data_index : int = -1


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

		var tex : Texture2D

		if hydration < hydration_limits.x:
			tex = underhydrate_tex

		else:
			tex = overhydrate_tex

		for child in tomato_sprites_container.get_children():

			if !(child is Sprite2D):
				continue

			(child as Sprite2D).texture = tex

		warnings.visible = false

		on_died.emit(self)


func _enter_tree() -> void:

	initialize_hydration()

	pass


func _ready() -> void:

	# Turn off all tilemap layers to start
	for i in range(tilemap.get_layers_count()):
		tilemap.set_layer_enabled(i, false)

	check_for_tilemap_update()

	start_points_timer()

	if start_empty:
		make_row_empty()

	pass


func _process(_delta: float) -> void:

	check_for_tilemap_update()

	pass


func initialize_hydration() -> void:

	hydration = Random.randf_range_vec2(healthy_hydration_range)


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

	push_error("If here, something is messed up with thresholds / layering for soil hydration")

	pass


func make_row_empty() -> void:

	dead = true

	sprinkler.visible = false
	tomato_sprites_container.visible = false
	sprinkler_nozzles_container.visible = false
	warnings.visible = false

	tilemap.set_layer_enabled(current_enabled_layer, false)
	tilemap.set_layer_enabled(field_row_coloring_data[empty_field_row_coloring_data_index].layer, true)

	pause_points_timer()
	set_process(false)


func revive() -> bool:

	if !dead:
		return false

	dead = false

	sprinkler.visible = true
	tomato_sprites_container.visible = true
	sprinkler_nozzles_container.visible = true
	warnings.visible = true

	for child in tomato_sprites_container.get_children():

		if !(child is Sprite2D):
			continue

		(child as Sprite2D).texture = base_tomato_tex

	initialize_hydration()
	sprinkler.toggle_from_row_status()
	check_for_tilemap_update()

	unpause_points_timer()
	set_process(true)

	on_revive.emit(self)

	return true


func modify_hydration(modification) -> void:

	hydration += modification


func start_points_timer() -> void:

	var portion = (GameDifficultyScaling.instance.hydration_modifier_scale - min_difficulty) / (max_difficulty - min_difficulty)
	portion = clampf(portion, 0.0, 1.0)
	var time = lerpf(min_difficulty_point_timer_delay, max_difficulty_point_timer_delay, portion)

	points_timer.start(time)

	pass


func pause_points_timer() -> void:

	points_timer.paused = true


func unpause_points_timer() -> void:

	points_timer.paused = false


func _on_points_timer_timeout() -> void:

	PointManager.add_points(points_per_timer)

	start_points_timer()

	pass # Replace with function body.
