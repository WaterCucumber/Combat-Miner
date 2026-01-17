shader_type canvas_item;

uniform float brake_percent : hint_range(0.0, 1.0, 0.01);
uniform sampler2D brake_texture;
uniform sampler2D screen_texture : hint_screen_texture;

float lerp(float a, float b, float t){
	return (1.0 - t) * a + t * b;
}

vec3 lerp3(vec3 a, vec3 b, float t){
	float r = lerp(a.r, b.r, t);
	float g = lerp(a.g, b.g, t);
	float b1 = lerp(a.b, b.b, t);
	return vec3(r, g, b1);
}

void fragment() {
	vec3 tex_col = texture(brake_texture, UV).rgb * brake_percent;
	vec3 screen_col = texture(TEXTURE, UV).rgb;
	COLOR.rgb = screen_col * lerp3(vec3(1,1,1), tex_col, brake_percent);
}