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

    /*if(color.r > x){
    	outputColor.r = clamp(x + color.r, 0.0, 1.0);
    	outputColor.g = 0.0;
	    outputColor.b = 0.0;
	    outputColor.a = clamp(x + color.r, 0.0, 1.0);
    } else {
   		outputColor.r = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
   		outputColor.g = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	    outputColor.b = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	    outputColor.a = color.a;
    }*/

    //if(enable){
    	if(color.r >= x){
    	//outputColor.r = x + color.r;
	    	outputColor.r = clamp(color.r - x, 0.0, 1.0);
	    } else {
	   		outputColor.r = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	    }

	    if(color.g >= y){
	    	//outputColor.g = y + color.g;
	    	outputColor.g = clamp(color.g - y, 0.0, 1.0);
	    } else {
	   		outputColor.g = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	   	}

	    if(color.b >= z){
	    	//outputColor.b = z + color.b;
	    	outputColor.b = clamp(color.b - z, 0.0, 1.0);
	    } else {
	   		outputColor.b = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
		}
	/*} else {
   		outputColor.r = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
   		outputColor.g = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
   		outputColor.b = clamp(color.r * 0.299 + color.g * 0.587 + color.b * 0.114, 0.0, 1.0);
	}*/
   
   	outputColor.a = a;

    return outputColor;
}

void main (void){
  vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
  gl_FragColor = vec4(Effect1(texColor));
}