#define PROCESSING_TEXTURE_SHADER

uniform float radius;
uniform float angle;
uniform vec2 center;
varying vec2 vertTexCoord;

uniform vec2 vertex;
uniform sampler2D texture;

void main() {
    //gl_Position = vec4(vertex * 2.0 - 1.0, 0.0, 1.0);

    vertTexCoord -= center;
    float distancee = length(vertTexCoord);
    if (distancee < radius) {
        float percent = (radius - distancee) / radius;
        float theta = percent * percent * angle;
        float s = sin(theta);
        float c = cos(theta);
        vertTexCoord = vec2(
            vertTexCoord.x * c - vertTexCoord.y * s,
            vertTexCoord.x * s + vertTexCoord.y * c
        );
    }
    vertTexCoord += center;


    gl_FragColor = texture2D(texture, vertTexCoord);
}