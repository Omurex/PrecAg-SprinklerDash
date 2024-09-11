class_name BaseWeatherEffect

extends Node


@export_group("References")
@export var hydration_modifier_packed : PackedScene
@export var weather_icon : Texture2D


@export_group("Properties")
@export var hydration_modifier_amount : float
@export var hydration_modifier_delay : float
@export var duration_range : Vector2


var hydration_modifiers : Array[HydrationModifier]
var field : Field


func init(affected_field : Field) -> void:

	field = affected_field

	pass


func _ready() -> void:

	for row in field.rows:

		var hydration_modifier = hydration_modifier_packed.instantiate() as HydrationModifier

		hydration_modifier.initialize(hydration_modifier_amount, hydration_modifier_delay)

		row.add_child(hydration_modifier)

		hydration_modifiers.push_back(hydration_modifier)

	pass


func _exit_tree() -> void:

	for modifier in hydration_modifiers:

		modifier.queue_free()


