shader_type canvas_item;

uniform bool use_gradient = false;
uniform sampler2D gradient2D;
uniform float amount = 16;
uniform float offset = 0.5;

void fragment() {
	float value = COLOR.r;
	vec2 grid_uv = round(UV * float(amount) + offset) / float(amount);
	vec3 col = texture(gradient2D, grid_uv).rgb;
	if (use_gradient) {
		COLOR.rgb = col * value;
	}
	else {
		COLOR = COLOR;
	}
}
