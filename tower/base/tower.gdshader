shader_type canvas_item;

const vec2 CENTER = vec2(0.5, 0.5);
const float RADIUS = 0.493;
uniform float border_width = 0.02;
uniform vec4 fill_color : source_color = vec4(1.0, 0.2, 0.2, 0.10);
uniform vec4 border_color : source_color = vec4(1.0, 0.4, 0.0, 0.6);

void fragment() {
    float d = distance(UV, CENTER);
    float eps = 0.005;
    float inner_transition = smoothstep(RADIUS - border_width * 0.5 - eps, RADIUS - border_width * 0.5 + eps, d);
    float outer_transition = smoothstep(RADIUS + border_width * 0.5 - eps, RADIUS + border_width * 0.5 + eps, d);
    float fill_mask = 1.0 - inner_transition;
    float border_mask = inner_transition * (1.0 - outer_transition);
    float final_alpha = fill_mask * fill_color.a + border_mask * border_color.a;
    vec3 final_color = fill_color.rgb * fill_mask + border_color.rgb * border_mask;
    COLOR = d > (RADIUS + border_width * 0.5) ? vec4(0.0) : vec4(final_color, final_alpha);
}
