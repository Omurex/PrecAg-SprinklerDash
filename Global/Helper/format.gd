class_name Format


static func format_points_to_default(points : int) -> String:

	return format_points(points, 6)


static func format_points(points : int, target_num_digits) -> String:

	var points_str = str(points)

	var points_initial_len = points_str.length()

	for i in range(target_num_digits - points_initial_len): # Padding 0s at the front
		#label_text += "0"
		points_str = "0" + points_str


	var index = target_num_digits - 3

	while index > 0:

		points_str = points_str.insert(index, ",")
		index -= 3

	return points_str
