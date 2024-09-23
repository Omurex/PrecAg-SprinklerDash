class_name WeatherSystem

extends Node

signal on_weather_effect_started(weather_effect : BaseWeatherEffect)
signal on_weather_effect_ended(weather_effect : BaseWeatherEffect)

@export_group("References")
@export var weather_effects_packed : Array[PackedScene]
@export var timer : Timer
@export var field : Field

@export_group("Properties")
@export var first_weather_effect_delay_range : Vector2
@export var weather_effect_delay_range : Vector2


var weather_effects : Array[BaseWeatherEffect]

var current_weather_effect : BaseWeatherEffect = null
var queued_weather_effect : BaseWeatherEffect = null


func _ready() -> void:

	start_timer()

	for packed in weather_effects_packed:
		var effect = packed.instantiate() as BaseWeatherEffect
		effect.init(field)
		add_child(effect)
		weather_effects.push_back(effect)

	pass


func start_timer():
	timer.start(Random.randf_range_vec2(first_weather_effect_delay_range))


func stop_timer():
	timer.stop()


func start_random_weather_effect() -> void:

	stop_current_weather_effect()

	if queued_weather_effect == null:
		current_weather_effect = select_random_weather_effect()

	else:
		current_weather_effect = queued_weather_effect
		queued_weather_effect = null

	current_weather_effect.start_weather_effect()

	on_weather_effect_started.emit(current_weather_effect)

	pass


func stop_current_weather_effect() -> void:

	if current_weather_effect == null:
		return

	on_weather_effect_ended.emit(current_weather_effect)

	current_weather_effect.end_weather_effect()

	current_weather_effect = null

	pass


func select_random_weather_effect() -> BaseWeatherEffect:

	return weather_effects.pick_random()


func request_next_weather_effect() -> BaseWeatherEffect:

	if queued_weather_effect == null:
		queued_weather_effect = select_random_weather_effect()

	return queued_weather_effect


func is_weather_effect_in_progress() -> bool:

	return current_weather_effect != null


# Note: Depending on weather state, this can either be time left until next weather
# effect, or time left until weather effect end. Use is_weather_effect_in_progress to check!
# Returns inf if timer is stopped
func get_time_left() -> float:

	if timer.is_stopped():
		return INF

	return timer.time_left


func _on_timer_timeout() -> void:

	if current_weather_effect == null:

		start_random_weather_effect()
		timer.start(Random.randf_range_vec2(current_weather_effect.duration_range))

	else:

		stop_current_weather_effect()
		timer.start(Random.randf_range_vec2(weather_effect_delay_range))

	pass
