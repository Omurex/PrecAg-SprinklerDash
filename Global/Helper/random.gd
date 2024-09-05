class_name Random


static func randf_range_vec2(vec2_range : Vector2) -> float:

	if vec2_range.x > vec2_range.y:
		vec2_range = Vector2(vec2_range.y, vec2_range.x)

	return randf_range(vec2_range.x, vec2_range.y)


static func randi_range_vec2(vec2_range : Vector2i) -> int:

	if vec2_range.x > vec2_range.y:
		vec2_range = Vector2i(vec2_range.y, vec2_range.x)

	return randi_range(vec2_range.x, vec2_range.y)
