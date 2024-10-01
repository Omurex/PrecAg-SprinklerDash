extends TextureRect


@export_group("Internal References")


@export_group("External References")


@export_group("Properties")
@export var play_fps : float = 15
@export var sprite_dimensions : Vector2i
@export var num_columns : int
@export var num_sprites : int


var atlas : AtlasTexture


var time_passed := 0.0
var sprites_played := 0
var num_columns_played := 0


func _ready() -> void:

	atlas = texture as AtlasTexture

	atlas.region.position = Vector2i(0, 0)
	#atlas.region.size = sprite_dimensions
	atlas.region.size = Vector2(sprite_dimensions.x, sprite_dimensions.y)

	pass


func _process(delta: float) -> void:

	time_passed += delta

	if time_passed >= 1 / play_fps:
		time_passed = 0

		num_columns_played += 1
		sprites_played += 1

		if sprites_played >= num_sprites:
			num_columns_played = 0
			sprites_played = 0
			atlas.region.position = Vector2i(0, 0)

		elif num_columns_played >= num_columns:
			num_columns_played = 0
			atlas.region.position = Vector2(0, atlas.region.position.y + sprite_dimensions.y)

		else:
			atlas.region.position.x += sprite_dimensions.x


