shader_type canvas_item;

uniform vec4 sunshine_color : source_color;


void fragment() {

	float intensity = UV.x * (1.0 - UV.y);

	COLOR = sunshine_color * intensity;//vec4(intensity, intensity, 1, 1);
	// Called for every pixel the material is visible on.
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
