shader_type canvas_item;

uniform vec3 dark_color  : source_color;
uniform vec3 light_color : source_color;

uniform vec2 hole_position;
uniform float hole_size : hint_range(0.0, 1.0);

uniform float stripes : hint_range(0.0, 100.0, 1.0);
uniform float stripe_curve : hint_range(0.0, 20.0);
uniform float spin_speed : hint_range(0.0, 1.0);

uniform sampler2D noise : repeat_enable;

const float aratio = 1.7777;

float atan2(vec2 vector) {
	return atan( vector.y / vector.x ) + PI * float(vector.x < 0.0);
}

void fragment() {
	vec2 uv = UV + texture(noise, UV + TIME * 0.025).rg * 0.04;
	
	vec2 diff  = uv - hole_position;
	diff.x *= aratio;
	
	float dist = length(diff);
	float angle = atan2(diff);
	
	float size_displacement = 1.0 + sin(TIME) * 0.1;
	COLOR.rgb = mix(dark_color, light_color, float(dist > hole_size * size_displacement));
	
	float angle_wave = sin(angle * stripes - TIME * spin_speed + dist * stripe_curve);
	if (angle_wave > - dist * 0.5) {
		COLOR.rgb = dark_color;
	}
	if (angle_wave > .7 - dist* 0.5) {
		COLOR.rgb = dark_color * 0.6;
	}
	
	COLOR.rgb = mix(COLOR.rgb, dark_color * 0.6, float(dist < hole_size * 0.75 * size_displacement));
	COLOR.rgb *= 1.0 - float(dist < hole_size * 0.5 * size_displacement) * 0.4;
	COLOR.rgb *= 1.0 - float(dist / 2.0);
}
