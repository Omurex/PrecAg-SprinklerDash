class_name ExtremeHeatWeatherEffect

extends BaseWeatherEffect


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")
@export var sprinkler_on_hydration_amount : float = -3
@export var sprinkler_off_hydration_amount : float = -8


func _ready() -> void:

	super()

	for modifier in hydration_modifiers:

		(modifier as SprinklerDependentHydrationModifier).\
			initialize_sprinkler_dependent_hydration_modifier(\
			sprinkler_on_hydration_amount, sprinkler_off_hydration_amount)

