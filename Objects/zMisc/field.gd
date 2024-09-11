class_name Field

extends Node2D


@export_group("References")


@export_group("Properties")


var rows : Array[FieldRow]


func _enter_tree() -> void:

	var children = get_children()

	for child in children:
		rows.push_back(child as FieldRow)


func _ready() -> void:
	pass

