class_name HydrationModifier

extends Node


@export_group("References")


@export_group("Properties")
@export var mod_amount_per_sec : float = 0


var field_row : FieldRow



func initialize(mod_amount : float):

	mod_amount_per_sec = mod_amount


func _ready() -> void:

	assert(get_parent() is FieldRow, "Hydration Modifier must be direct child of Field Row!")

	field_row = get_parent() as FieldRow

	pass


func _process(delta: float) -> void:

	field_row.modify_hydration(mod_amount_per_sec * delta)

	if Input.is_action_just_pressed("ui_up"):
		mod_amount_per_sec *= -1

	pass

