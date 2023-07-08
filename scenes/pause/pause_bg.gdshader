shader_type canvas_item;

uniform float alpha = 0.25;

void fragment() {
	COLOR.a = sin(PI * UV.y) * alpha;
}
