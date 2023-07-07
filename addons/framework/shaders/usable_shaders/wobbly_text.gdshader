shader_type canvas_item;

uniform float wobble : hint_range(.0, 16.0);
uniform float speed : hint_range(0.0, 10.0);

void vertex() {
	VERTEX.y += sin(VERTEX.x + TIME * speed) * wobble * 0.5;
}
