class_name WeatherIconVisual

extends Node


@export_group("References")
@export var tex_rect : TextureRect
@export var warning_flash_timer : Timer
@export var weather_system : WeatherSystem


@export_group("Properties")
@export var warning_time : float = 5


var is_warning := false


func _ready() -> void:

	weather_system.on_weather_effect_started.connect(show_icon)
	weather_system.on_weather_effect_ended.connect(hide_icon)

	hide_icon(null)

	pass


func _process(_delta: float) -> void:

	if weather_system.is_weather_effect_in_progress():
		return

	if !is_warning and weather_system.get_time_left() <= warning_time:

		tex_rect.texture = weather_system.request_next_weather_effect().weather_icon
		is_warning = true
		_on_warning_flash_timer_timeout()

	pass


func show_icon(weather_effect : BaseWeatherEffect):

	is_warning = false
	tex_rect.texture = weather_effect.weather_icon
	tex_rect.visible = true

	pass


func hide_icon(_weather_effect : BaseWeatherEffect):

	tex_rect.visible = false

	pass


func _on_warning_flash_timer_timeout() -> void:

	if is_warning == false:
		return

	tex_rect.visible = !tex_rect.visible

	warning_flash_timer.start()

	pass # Replace with function body.
