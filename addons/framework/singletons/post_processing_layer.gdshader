shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform vec2 res = vec2(256, 150);

vec2 snap(vec2 vector) {
	return floor(vector * res) / res;
}

void fragment() {
	vec2 snapped_uv = floor(UV * res) / res;
	
	vec2 offset = SCREEN_PIXEL_SIZE * 2.0;
	
	vec3 pixel = texture(SCREEN_TEXTURE, snapped_uv).rgb;
	vec3 NE = texture(SCREEN_TEXTURE, snap(UV + offset * vec2(1.0, -1.0))).rgb;
	vec3 NW = texture(SCREEN_TEXTURE, snap(UV + offset * vec2(-1.0, -1.0))).rgb;
	vec3 SE = texture(SCREEN_TEXTURE, snap(UV + offset * vec2(1.0, 1.0))).rgb;
	vec3 SW = texture(SCREEN_TEXTURE, snap(UV + offset * vec2(-1.0, 1.0))).rgb;
	
	if (NE == SW && NW == SE) {
		COLOR = vec4(pixel, 1.0);
		
	} else {
	
		if (NE == SW && pixel != NE) {
			pixel = NE;
		} else if (NW == SE && pixel != NW) {
			pixel = NW;
		}
		
		COLOR = vec4(pixel, 1.0);
	}
}
