class_name WeatherSystem

extends Node

signal on_weather_effect_started(weather_effect : BaseWeatherEffect)
signal on_weather_effect_ended(weather_effect : BaseWeatherEffect)

@export_group("References")
@export var weather_effects : Array[PackedScene]
@export var timer : Timer
@export var field : Field

@export_group("Properties")
@export var first_weather_effect_delay_range : Vector2
@export var weather_effect_delay_range : Vector2


var current_weather_effect : BaseWeatherEffect = null


func _ready() -> void:

	timer.start(Random.randf_range_vec2(first_weather_effect_delay_range))

	pass


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:

	if current_weather_effect == null:

		start_random_weather_effect()
		timer.start(Random.randf_range_vec2(current_weather_effect.duration_range))

	else:

		stop_current_weather_effect()
		timer.start(Random.randf_range_vec2(weather_effect_delay_range))

	pass


func start_random_weather_effect() -> void:

	stop_current_weather_effect()

	current_weather_effect = weather_effects.pick_random().instantiate() as BaseWeatherEffect

	current_weather_effect.init(field)

	add_child(current_weather_effect)

	on_weather_effect_started.emit(current_weather_effect)

	pass


func stop_current_weather_effect() -> void:

	if current_weather_effect == null:
		return

	on_weather_effect_ended.emit(current_weather_effect)

	current_weather_effect.queue_free()
	current_weather_effect = null

	pass

