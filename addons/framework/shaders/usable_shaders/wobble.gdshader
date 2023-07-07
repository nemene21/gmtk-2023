shader_type canvas_item;

uniform float speed : hint_range(0.0, 5.0) = 1.0;
uniform float smoothness : hint_range(0.0, 100.0) = 6.0;
uniform float strength : hint_range(0.0, 0.2) = 0.04;
uniform sampler2D noise : repeat_enable;
uniform float flash : hint_range(.0, 1.0);

void vertex() {
	VERTEX *= 1.0 + strength * 0.5;
	UV -= 0.5;
	UV *= 1.0 + strength * 0.5;
	UV += 0.5;
}

void fragment() {
	vec2 offset = texture(noise, UV + floor(TIME * smoothness) / smoothness * speed).xy - 0.5;
	vec2 coords = UV + offset * strength;
	COLOR = texture(TEXTURE, coords);
	COLOR.a *= float(
		coords.x > 0.0 && coords.x < 1.0 &&
		coords.y > 0.0 && coords.y < 1.0
	);
	COLOR.rgb = COLOR.rgb * (1.0 - flash) + flash;
}
