#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;


uniform float x;
uniform float y;
uniform float z;
uniform float a;
uniform bool enable;


vec4 Effect1( in vec4 color )
{
    vec4 outputColor = vec4(0,0,0,0);

	if(color.r >= x){
    	outputColor.r = clamp(color.r - x, 0.0, 1.0);
    } else {
   		outputColor.r = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
    }

    if(color.g >= y){
    	outputColor.g = clamp(color.g - y, 0.0, 1.0);
    } else {
   		outputColor.g = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
   	}

    if(color.b >= z){
    	outputColor.b = clamp(color.b - z, 0.0, 1.0);
    } else {
   		outputColor.b = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	}
   
  if(color.a == 0.0){
    outputColor.a = 0.0;
  } else {
    outputColor.a = a;
  }
 	

  return outputColor;
}

void main (void){
  vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
  gl_FragColor = vec4(Effect1(texColor));
}