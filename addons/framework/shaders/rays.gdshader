shader_type canvas_item;
render_mode blend_add;

uniform int ray_count = 5;
uniform float width : hint_range(-1.0, 1.0);
uniform sampler2D gradient;
uniform float speed : hint_range(-32.0, 32.0) = 1.0;

const vec2 center = vec2(.5, .5);

float atan2(vec2 vector) {
	return atan( vector.y / vector.x ) + PI * float(vector.x < 0.0);
}

void fragment() {
	vec2 difference = UV - center;
	float dist = length(difference);
	float animation = 1.0 - dist * 2.0;
	float angle = atan2(difference) * float(ray_count);
	COLOR.a *= texture(gradient, vec2(animation, .0)).a;
	COLOR.a *= float(sin(angle + TIME * speed) < width) * float(animation > .0);
}
