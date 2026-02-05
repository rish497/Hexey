shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 50.0) = 100.0;
uniform int blur_steps : hint_range(1, 20) = 100;

void fragment() {
	vec2 tex_pixel_size = 1.0 / vec2(textureSize(TEXTURE, 0));
	vec4 color = texture(TEXTURE, UV);

	for (int i = 0; i < blur_steps; i++) {
		float angle = float(i) * TAU / float(blur_steps);
		vec2 offset = vec2(cos(angle), sin(angle)) * blur_amount * tex_pixel_size;
		color += texture(TEXTURE, UV + offset);
	}

	COLOR = color / float(blur_steps + 1);
}
