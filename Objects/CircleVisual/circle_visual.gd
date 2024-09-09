class_name CircleVisual

extends Node2D


@export_group("References")
@export var inner_circle : Sprite2D
@export var outer_circle : Sprite2D
@export var hydration_circle : Sprite2D
@export var field_row : FieldRow

@export_group("Properties")
@export var min_scale : float = 0
@export var max_scale : float = 2.15

var inner_circle_value : float = 0
var outer_circle_value : float = 0



func _ready() -> void:

	inner_circle_value = field_row.healthy_hydration_range.x
	outer_circle_value = field_row.healthy_hydration_range.y

	pass


func _process(_delta: float) -> void:

	if field_row.dead:
		queue_free()

	hydration_circle.scale = calculate_scale(field_row.hydration)

	pass


func calculate_scale(val : float) -> Vector2:

	var portion : float
	var scale_amount : float

	if val <= inner_circle_value:

		portion = (val - field_row.hydration_limits.x) / (inner_circle_value - field_row.hydration_limits.x)
		scale_amount = lerpf(min_scale, inner_circle.scale.x, portion)

		pass

	elif val >= outer_circle_value:

		portion = (field_row.hydration_limits.y - val) / (field_row.hydration_limits.y - outer_circle_value)
		scale_amount = lerpf(max_scale, outer_circle.scale.x, portion)

		pass

	else:

		portion = (val - inner_circle_value) / (outer_circle_value - inner_circle_value)
		scale_amount = lerpf(inner_circle.scale.x, outer_circle.scale.x, portion)

	return Vector2(scale_amount, scale_amount)


















