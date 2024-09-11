shader_type canvas_item;

uniform vec4 source_sunshine_color : source_color;
uniform vec4 min_sunshine_color : source_color;


void fragment() {

	float t = UV.x * (1.0 - UV.y);

	vec4 sunshine_color = mix(min_sunshine_color, source_sunshine_color, t);

	COLOR = sunshine_color;//vec4(intensity, intensity, 1, 1);
	// Called for every pixel the material is visible on.
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
