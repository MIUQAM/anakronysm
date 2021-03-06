#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
//uniform sampler2D maskTexture;
uniform sampler2D maskTexture_f0;
uniform sampler2D maskTexture_f1;
uniform sampler2D maskTexture_f2;
uniform sampler2D maskTexture_f3;
uniform sampler2D maskTexture_f4;

varying vec4 vertTexCoord;

vec4 Mask( in vec4 color, in vec4 maskColor )
{
    return vec4(
          color.r * 1.25,
          color.g * 1.25,
          color.b * 1.25,
          clamp(color.a * maskColor.r, 0.0, 1.0)
    );
}

void main (void){
    
	vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
	vec4 maskColor_f0 = texture2D(maskTexture_f0, vec2(vertTexCoord.x, 1.0 - vertTexCoord.y)).rgba;
	vec4 maskColor_f1 = texture2D(maskTexture_f1, vec2(vertTexCoord.x, 1.0 - vertTexCoord.y)).rgba;
	vec4 maskColor_f2 = texture2D(maskTexture_f2, vec2(vertTexCoord.x, 1.0 - vertTexCoord.y)).rgba;
	vec4 maskColor_f3 = texture2D(maskTexture_f3, vec2(vertTexCoord.x, 1.0 - vertTexCoord.y)).rgba;
	vec4 maskColor_f4 = texture2D(maskTexture_f4, vec2(vertTexCoord.x, 1.0 - vertTexCoord.y)).rgba;
	vec4 maskColor_total = maskColor_f0 + maskColor_f1 + maskColor_f2 + maskColor_f3 + maskColor_f4;

  	gl_FragColor = vec4(Mask(texColor, maskColor_total));
}

