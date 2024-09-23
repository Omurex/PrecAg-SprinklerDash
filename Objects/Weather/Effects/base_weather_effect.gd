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


func _ready() -> void:

	end_weather_effect()


func init(affected_field : Field) -> void:

	field = affected_field

	pass


func start_weather_effect() -> void:
	push_error("THIS IS AN ABSTRACT FUNCTION THAT SHOULD BE OVERRIDDEN")
	pass


func end_weather_effect() -> void:
	push_error("THIS IS AN ABSTRACT FUNCTION THAT SHOULD BE OVERRIDDEN")
	pass


# Note: It'd be better to use the pause functionality of the hydration modifiers instead of adding / removing
# them whenever the weather status changes, however due to the way the code is currently architected and the timeline we're working with,
# we're not going to do the refactor needed to make that work
func add_hydration_modifiers() -> void:

	remove_hydration_modifiers()

	for row in field.rows:

		var hydration_modifier = hydration_modifier_packed.instantiate() as HydrationModifier

		hydration_modifier.initialize(hydration_modifier_amount, hydration_modifier_delay)

		row.add_child(hydration_modifier)

		hydration_modifiers.push_back(hydration_modifier)

	pass


func remove_hydration_modifiers() -> void:

	for modifier in hydration_modifiers:
		modifier.queue_free()

	hydration_modifiers.clear()


func _exit_tree() -> void:

	remove_hydration_modifiers()

