class_name Player

extends CharacterBody2D


@export_group("References")
@export var animated_sprite : AnimatedSprite2D


@export_group("Properties")
@export var move_speed : float


const input_to_anim = {
	1 : "walk_right",
	-1 : "walk_left",
	0 : "idle_down"
}


var input : float


func _process(_delta: float) -> void:

	input = Input.get_axis("left", "right")

	animated_sprite.play(input_to_anim[roundi(input)])

	print(input)

	pass


func _physics_process(_delta: float) -> void:

	velocity = Vector2(input, 0) * move_speed

	move_and_slide()

	pass

