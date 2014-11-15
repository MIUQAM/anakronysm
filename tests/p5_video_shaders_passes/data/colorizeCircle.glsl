#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D maskTexture;
varying vec4 vertTexCoord;

vec4 Mask( in vec4 color, in vec4 maskColor )
{
    return vec4(
          color.r
        , color.g
        , color.b
        , color.a * (1.0 - maskColor.r)
    );
}

void main (void){
  vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
  vec4 maskColor = texture2D(maskTexture, vertTexCoord.xy).rgba;

  gl_FragColor = vec4(Mask(texColor, maskColor));
}