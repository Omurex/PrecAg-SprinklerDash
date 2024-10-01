extends TextureRect


@export_group("Internal References")


@export_group("External References")
@export var other_tex_region : Rect2


@export_group("Properties")
@export var flip_time : float = 1


var atlas : AtlasTexture
var time_passed : float = 0


func _ready() -> void:

	atlas = texture as AtlasTexture

	pass


func _process(delta: float) -> void:

	time_passed += delta

	if time_passed >= flip_time:

		time_passed = 0

		var temp = atlas.region
		atlas.region = other_tex_region
		other_tex_region = temp

	pass

