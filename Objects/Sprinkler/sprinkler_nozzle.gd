class_name SprinklerNozzle

extends Node2D


@export_group("References")
@export var water_emitter : CPUParticles2D
@export var sprite : Sprite2D


@export_group("Properties")
@export var facing_right := true



func _ready() -> void:

	var sign_dir = (2 * int(facing_right)) - 1

	water_emitter.direction.x  = abs(water_emitter.direction.x) * sign_dir
	sprite.scale.x = abs(sprite.scale.x) * sign_dir

	pass


func _process(delta: float) -> void:
	pass


func toggle(on : bool) -> void:

	water_emitter.emitting = on

