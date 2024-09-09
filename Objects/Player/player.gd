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
var detected_sprinkler : Sprinkler = null


func _process(_delta: float) -> void:

	input = Input.get_axis("left", "right")

	animated_sprite.play(input_to_anim[roundi(input)])

	sprinkler_interaction()

	pass


func _physics_process(_delta: float) -> void:

	velocity = Vector2(input, 0) * move_speed

	move_and_slide()

	pass


func sprinkler_interaction() -> void:

	if detected_sprinkler != null and Input.is_action_just_pressed("interact"):

		detected_sprinkler.flip()



func _on_sprinkler_detector_area_entered(area: Area2D) -> void:

	assert(area is SprinklerCollision)

	detected_sprinkler = (area as SprinklerCollision).sprinkler

	pass # Replace with function body.



func _on_sprinkler_detector_area_exited(area: Area2D) -> void:

	if area == detected_sprinkler:

		detected_sprinkler = null

	pass # Replace with function body.
