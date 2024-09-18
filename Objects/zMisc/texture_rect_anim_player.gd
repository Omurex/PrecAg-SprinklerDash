class_name TextureRectAnimPlayer

extends TextureRect


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")
@export var fps : float = 1.5
@export var start_x : int = -1
@export var end_x : int = -1


var atlas_texture : AtlasTexture
var time_passed := 0.0

var frame_x := 0


func _ready() -> void:

	assert(texture is AtlasTexture)
	atlas_texture = texture as AtlasTexture

	frame_x = start_x
	update_texture(frame_x)

	pass


func _process(delta: float) -> void:

	time_passed += delta

	if time_passed >= 1 / fps:

		frame_x += 1

		if frame_x > end_x:
			frame_x = start_x

		update_texture(frame_x)

		time_passed = 0

	pass


func update_texture(index : int) -> void:

	atlas_texture.region.position.x = index * atlas_texture.region.size.x

	pass

