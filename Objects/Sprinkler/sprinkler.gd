class_name Sprinkler

extends Node2D


@export_group("References")
@export var hydration_modifier_packed : PackedScene
@export var field_row : FieldRow
@export var nozzle_parent : Node

@export_group("Properties")
@export var modification_amount : float = 4


var hydration_modifier : HydrationModifier = null
var on : bool = false

var nozzle_refs : Array[SprinklerNozzle]


func _ready() -> void:

	var mid = (field_row.healthy_hydration_range.x + field_row.healthy_hydration_range.y) / 2
	on = field_row.hydration <= mid

	hydration_modifier = hydration_modifier_packed.instantiate() as HydrationModifier
	hydration_modifier.initialize(abs(modification_amount) * get_sign())

	field_row.add_child.call_deferred(hydration_modifier)

	load_nozzle_refs_from_children()

	toggle_nozzle_visuals(on)

	pass


func load_nozzle_refs_from_children():

	var children = nozzle_parent.get_children()

	for child in children:

		if child is SprinklerNozzle:

			nozzle_refs.push_back(child as SprinklerNozzle)

	pass


func toggle_nozzle_visuals(nozzle_on : bool):

	for nozzle in nozzle_refs:

		nozzle.toggle(nozzle_on)


func get_sign() -> int:

	return (2 * int(on)) - 1


func toggle(status : bool) -> void:

	on = status

	hydration_modifier.mod_amount_per_sec = abs(hydration_modifier.mod_amount_per_sec) * get_sign()

	toggle_nozzle_visuals(on)


func flip() -> bool:

	toggle(!on)
	return on

