#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;

vec4 Sepia( in vec4 color )
{
    return vec4(
          clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0),
          clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0),
          clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0),
          color.a
    );
}

void main (void){
  vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
  gl_FragColor = vec4(Sepia(texColor));
}