shader_type canvas_item;

uniform float speed : hint_range(0.0, 10.0, 0.1) = 5.0;
uniform vec2 direction = vec2(1.0, 0.0);

void fragment() {
	COLOR = texture(TEXTURE, UV + direction * speed * TIME);
}
