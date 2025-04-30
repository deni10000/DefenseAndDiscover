shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float speed = 1.0;
uniform float frequency = 10.0;
uniform float thickness = 0.05;

void fragment() {
    float dist = distance(UV, center);
	if (dist <= 0.5){
	    float wave = sin((dist - TIME * speed) * frequency);
	    float alpha = 1.0 - smoothstep(0.0, thickness, abs(wave));
	    COLOR = vec4(vec3(1.0), alpha * 2.5 * (0.5 - dist));
	} else {
		COLOR = vec4(vec3(1.0), 0);
	}
}
