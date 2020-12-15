precision mediump float;
uniform vec2 uRenderSize;
#define CENTER vec2(0.5, 0.45)
#define MARKER_RADIUS vec2(0.35, 0.25)

float ellipse(vec2 point, vec2 center, vec2 radii) {
    vec2 dist = (point - center) / radii;
    float len = dist.x * dist.x + dist.y * dist.y;
    return smoothstep(1., 1.03, len) * 0.3;
}

void main() {
    vec2 point = gl_FragCoord.xy / uRenderSize.xy;
    float alpha = 0.0;
    alpha += ellipse(point, CENTER, MARKER_RADIUS);
    gl_FragColor = vec4(vec3(0.), alpha);
}

