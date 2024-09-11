class_name WeatherIconVisual

extends Node


@export_group("References")
@export var weather_system : WeatherSystem
@export var tex_rect : TextureRect


@export_group("Properties")



func _ready() -> void:

	weather_system.on_weather_effect_started.connect(show_icon)
	weather_system.on_weather_effect_ended.connect(hide_icon)

	pass


func _process(delta: float) -> void:
	pass


func show_icon(weather_effect : BaseWeatherEffect):

	tex_rect.texture = weather_effect.weather_icon
	tex_rect.visible = true

	pass


func hide_icon(weather_effect : BaseWeatherEffect):

	tex_rect.visible = false

	pass


