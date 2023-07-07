shader_type canvas_item;

uniform float flash : hint_range(0.0, 1.0, 0.1) = 0.0;

vec4 lerp(vec4 a, vec4 b, float c) {
	return a + (b - a) * c;
}

void fragment() {
	vec4 pixel = texture(TEXTURE, UV);
	COLOR = lerp(pixel, vec4(1.0, 1.0, 1.0, pixel.a), flash);
}
