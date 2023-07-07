shader_type canvas_item;

uniform vec2 repeats = vec2(1, 1);

void vertex() {
	VERTEX *= repeats;
}

void fragment() {
	COLOR = texture(TEXTURE, UV * repeats);
}

