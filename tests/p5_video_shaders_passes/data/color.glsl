#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform vec2 texOffset;
uniform vec2 resolution;

uniform vec3 colorFilter;

void main(void)
{
    vec3 texColor = texture2D(texture, vertTexCoord.xy).xyz;
    vec3 invert = vec3(1.0, 1.0, 1.0) - colorFilter;
    
    gl_FragColor = vec4(texColor + colorFilter, 1.0);
}