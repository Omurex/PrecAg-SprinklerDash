class_name CircleVisual

extends Node2D


@export_group("References")
@export var inner_circle : Sprite2D
@export var outer_circle : Sprite2D
@export var hydration_circle : Sprite2D
@export var field_row : FieldRow

@export_group("Properties")


var inner_circle_value : float = 0
var outer_circle_value : float = 0



func _ready() -> void:

	inner_circle_value = field_row.healthy_hydration_range.x
	outer_circle_value = field_row.healthy_hydration_range.y

	pass


func _process(_delta: float) -> void:

	hydration_circle.scale = calculate_scale(field_row.hydration)

	pass


func calculate_scale(val : float) -> Vector2:

	var portion = (val - inner_circle_value) / (outer_circle_value - inner_circle_value)

	var scale_amount = lerpf(inner_circle.scale.x, outer_circle.scale.x, portion)

	return Vector2(scale_amount, scale_amount)

