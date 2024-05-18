#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

const int GRID_SIZE = 10;
const float SATURATION = 0.8;
const float VALUE = 0.8;

// random function
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// hsv to rgb
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    // calculate the grid cell index
    vec2 gridIndex = vec2(floor(st.x * float(GRID_SIZE)), floor(st.y * float(GRID_SIZE)));

    // calculate the random initial hue angle for the current grid cell
    float initialHue = random(gridIndex) * 360.0;

    // calculate the current hue value based on the initial hue and time
    float currentHue = fract(initialHue / 360.0 + u_time * 0.2) * 360.0;

    // convert the hue value to an RGB color with adjustable saturation and value
    color = hsv2rgb(vec3(currentHue / 360.0, SATURATION, VALUE));

    gl_FragColor = vec4(color, 1.0);
}