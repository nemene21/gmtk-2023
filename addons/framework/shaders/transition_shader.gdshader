shader_type canvas_item;

uniform float animation : hint_range(0.0, 2.0);
uniform vec2  offset;
uniform vec2  res = vec2(1024, 600);

void fragment() {
	float value = texture(TEXTURE, floor(UV * res) / res + offset).r + animation - 1.0;
	float computed = float(value > 0.5);
	COLOR = vec4(0, 0, 0, clamp(computed, 0, 1));
}
