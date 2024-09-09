class_name Sprinkler

extends Node2D


@export_group("References")
@export var hydration_modifier_packed : PackedScene
@export var field_row : FieldRow

@export_group("Properties")
@export var modification_amount : float = 4


var hydration_modifier : HydrationModifier = null
var on : bool = false


func _ready() -> void:

	hydration_modifier = hydration_modifier_packed.instantiate() as HydrationModifier
	hydration_modifier.initialize(abs(modification_amount) * get_sign())

	field_row.add_child.call_deferred(hydration_modifier)

	pass


func get_sign() -> int:

	return (2 * int(on)) - 1


func toggle(status : bool) -> void:

	on = status

	hydration_modifier.mod_amount_per_sec = abs(hydration_modifier.mod_amount_per_sec) * get_sign()


func flip() -> bool:

	toggle(!on)
	return on

