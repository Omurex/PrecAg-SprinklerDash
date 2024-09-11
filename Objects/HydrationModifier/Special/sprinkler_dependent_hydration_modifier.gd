class_name SprinklerDependentHydrationModifier

extends HydrationModifier


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")


var on_mod : float = 0
var off_mod : float = 0


# Not a great way to do this, should find some way to do this favoring composition over inheritance
func initialize_sprinkler_dependent_hydration_modifier(\
	sprinkler_on_mod : float, sprinkler_off_mod : float):

	on_mod = sprinkler_on_mod
	off_mod = sprinkler_off_mod

	update_mod_amount_from_sprinkler_status()


func _process(_delta: float) -> void:

	super(_delta)

	update_mod_amount_from_sprinkler_status()

	pass


func update_mod_amount_from_sprinkler_status() -> void:

	if field_row.sprinkler.on:
		mod_amount_per_sec = on_mod

	else:
		mod_amount_per_sec = off_mod

