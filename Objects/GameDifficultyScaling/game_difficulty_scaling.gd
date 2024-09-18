class_name GameDifficultyScaling

extends Node


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")
@export var hydration_modifier_scale : float = 0
@export var hydration_modifier_scale_change_per_sec : float = 0


static var instance : GameDifficultyScaling


func _enter_tree() -> void:

	if instance == null:
		instance = self

	elif instance != self:
		queue_free()

	pass


func _process(delta: float) -> void:
	hydration_modifier_scale += hydration_modifier_scale_change_per_sec * delta
	print(hydration_modifier_scale)


func modify_scale(modification : float):
	hydration_modifier_scale = maxf(0, hydration_modifier_scale + modification)


func _exit_tree() -> void:

	if instance == self:
		instance = null

	pass

