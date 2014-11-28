#define PROCESSING_TEXTURE_SHADER

uniform float radius;
uniform float angle;
uniform vec2 center;
varying vec2 coord;

uniform vec2 vertex;
uniform sampler2D texture;
varying vec2 texCoord;

void main() {
    //gl_Position = vec4(vertex * 2.0 - 1.0, 0.0, 1.0);

    coord -= center;
    float distancee = length(coord);
    if (distancee < radius) {
        float percent = (radius - distancee) / radius;
        float theta = percent * percent * angle;
        float s = sin(theta);
        float c = cos(theta);
        coord = vec2(
            coord.x * c - coord.y * s,
            coord.x * s + coord.y * c
        );
    }
    coord += center;


    gl_FragColor = texture2D(texture, texCoord);
}