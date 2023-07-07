shader_type canvas_item;

uniform float width : hint_range(0.0, 128.0) = 2;
uniform int quality = 8;
uniform vec4 outline_color : source_color;

void vertex() {
	VERTEX *= 1.0 + TEXTURE_PIXEL_SIZE * width * 2.0;
}

void fragment() {
	vec2 fixed_uv = UV;
	fixed_uv -= 0.5;
	fixed_uv *= (1.0 + TEXTURE_PIXEL_SIZE * width * 2.0);
	fixed_uv += 0.5;
	
	COLOR = texture(TEXTURE, fixed_uv);
	
	if (fixed_uv.x < .0 || fixed_uv.x > 1.0 || fixed_uv.y < .0 || fixed_uv.y > 1.0 || COLOR.a == .0) {
		bool detected = false;
		float angle = (PI * 2.0) / float(quality);
		
		for (int i = 0; i < quality; i++) {
			vec2 offset = vec2(
				cos(angle * float(i)) * width * TEXTURE_PIXEL_SIZE.x,
				sin(angle * float(i)) * width * TEXTURE_PIXEL_SIZE.y
			);
			
			vec2 final = fixed_uv + offset;
			
			if (texture(TEXTURE, final).a > .0 && final.x > .0 && final.x < 1.0 && final.y > .0 && final.y < 1.0) {
				detected = true;
			}
		}
		
		if (detected) {
			COLOR = outline_color;
		} else {
			COLOR = vec4(.0, .0, .0, .0);
		}
	}
}
