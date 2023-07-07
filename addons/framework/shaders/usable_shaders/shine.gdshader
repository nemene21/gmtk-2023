shader_type canvas_item;

uniform vec4 shine_color : source_color = vec4(1, 1, 1, 1);
uniform float speed : hint_range(0.0, 5.0, 0.1) = 3.0;

void fragment() {
	vec4 pixel = texture(TEXTURE, UV);
	float mask = float(sin(TIME * 0.5 * speed + UV.x * 0.1 + UV.y * 0.1) > 0.999);
	COLOR = mix(pixel, shine_color, mask);
	COLOR.a = pixel.a;
}
