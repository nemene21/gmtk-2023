shader_type canvas_item;

uniform float sway : hint_range(0.0, 24.0) = 10.0;
uniform float speed : hint_range(0.0, 5.0, 0.1) = 1.0;

void vertex() {
	VERTEX.x += sin((1.0 - UV.y) * TIME * speed) * sway;
}
