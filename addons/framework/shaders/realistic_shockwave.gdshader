shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest_mipmap_anisotropic;
uniform float strength;
uniform float thickness : hint_range(0.0, 1.0);

void fragment() {
	float dist = distance(UV, vec2(.5, .5));
	float mask = (1.0 - smoothstep(0.0, thickness, dist)) * smoothstep(0.0, thickness, dist);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + mask * strength * 0.05);
	//COLOR = vec4(mask, mask, mask, 1.0);
}
