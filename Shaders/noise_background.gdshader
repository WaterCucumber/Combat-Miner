shader_type canvas_item;

uniform sampler2D noise;
uniform float offset_x : hint_range(0.0, 1.0, 0.01);
uniform float offset_y : hint_range(0.0, 1.0, 0.01);
uniform float scale : hint_range(0.01, 1.0, 0.01);
uniform int amount_x = 40;
uniform int amount_y = 40;

void fragment() {
	vec2 o = vec2(offset_x, offset_y);
	// from [0; 1] to [0; 0.94]
	o.x = o.x * 0.94;
	o.y = o.y * 0.94;
	vec2 uv = UV * scale + o;
	float grid_uv_x = round(uv.x * float(amount_x) / scale) / float(amount_x) * scale;
	float grid_uv_y = round(uv.y * float(amount_y) / scale) / float(amount_y) * scale;
	vec2 grid_uv = vec2(grid_uv_x, grid_uv_y);
	vec3 tex = texture(noise, grid_uv).rgb;

	COLOR.rgb = tex;
}
