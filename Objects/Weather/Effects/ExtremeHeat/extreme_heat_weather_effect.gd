class_name ExtremeHeatWeatherEffect

extends BaseWeatherEffect


const ALPHA_SHADER_PARAM_NAME = "alpha_mult"


@export_group("Internal References")
@export var sunshine_overlay : Panel
@export var audio_fader : AudioFader


@export_group("External References")


@export_group("Properties")
@export var sprinkler_on_hydration_amount : float = -3
@export var sprinkler_off_hydration_amount : float = -8
@export var sunshine_fade_time : float = 2
@export var audio_min : float = -80
@export var audio_max : float = -2


func _ready() -> void:

	super()
	update_overlay_alpha(0)


func _process(delta: float) -> void:
	pass

func specific_start_weather_effect() -> void:

	for modifier in hydration_modifiers:

		(modifier as SprinklerDependentHydrationModifier).\
			initialize_sprinkler_dependent_hydration_modifier(\
			sprinkler_on_hydration_amount, sprinkler_off_hydration_amount)


	update_overlay_alpha(0)

	var screen_fade_tween := get_tree().create_tween()
	screen_fade_tween.tween_method(update_overlay_alpha, 0.0, 1.0, sunshine_fade_time)

	sunshine_overlay.visible = true

	audio_fader.start_fade(sunshine_fade_time, audio_min, audio_max)
	audio_fader.play()

	#screen_fade_tween.tween_property(sunshine_overlay.material)
	#screen_fade_tween.tween_method(shader.set_shader_parameter.bind()

	#sunshine_overlay.modulate = Color(1, 1, 1, 0)

	# Modulate doesn't work since we use shader
	#screen_fade_tween.tween_property(sunshine_overlay, "modulate", Color(1, 1, 1, 1), sunshine_fade_time)


func specific_end_weather_effect() -> void:

	var screen_fade_tween := get_tree().create_tween()
	screen_fade_tween.tween_method(update_overlay_alpha, 1.0, 0.0, sunshine_fade_time)

	var screen_fade_timer := get_tree().create_timer(sunshine_fade_time)
	screen_fade_timer.timeout.connect(turn_off_overlay_visiblity)

	audio_fader.start_fade(sunshine_fade_time, audio_max, audio_min)

	pass


func turn_off_overlay_visiblity() -> void:
	sunshine_overlay.visible = false


func update_overlay_alpha(alpha : float):
	(sunshine_overlay.material as ShaderMaterial).set_shader_parameter(\
		ALPHA_SHADER_PARAM_NAME, alpha)

	# Modulate doesn't work since we use shader
	#sunshine_overlay.modulate = Color(1, 1, 1, 1)
#
	#var screen_fade_tween := get_tree().create_tween()
	#screen_fade_tween.tween_property(sunshine_overlay, "modulate", Color(1, 1, 1, 0), sunshine_fade_time)



