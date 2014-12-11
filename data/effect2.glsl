#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;

uniform float x;
uniform float y;
uniform float red;
uniform float green;
uniform float blue;
uniform float a;
uniform bool enable;


vec4 Effect1( in vec4 color )
{
    vec4 outputColor = vec4(0,0,0,0);

    if(color.a == 0.0){
    	outputColor.r = 0.0;
	    outputColor.g = 0.0;
	    outputColor.b = 0.0;
		outputColor.a = 0.0;
	} else {
		if(red == 1.0){
			outputColor.r = color.r;
		    outputColor.g = color.g * 0.85;
		    outputColor.b = color.b * 0.85;

		    if(color.r >= 0.5){
		    	outputColor.a = a * max(x,y);
		    } else {
		   		outputColor.a = 0.0;
		   	}
		} else if(green == 1.0){
			outputColor.r = color.r * 0.85;
		    outputColor.g = color.g;
		    outputColor.b = color.b * 0.85;

		    if(color.g >= 0.5){
		    	outputColor.a = a * max(x,y);
		    } else {
		   		outputColor.a = 0.0;
		   	}
		} else if(blue == 1.0){
			outputColor.r = color.r * 0.85;
		    outputColor.g = color.g * 0.85;
		    outputColor.b = color.b;

		    if(color.b >= 0.5){
		    	outputColor.a = a * max(x,y);
		    } else {
		   		outputColor.a = 0.0;
		   	}
		}
	}

    return outputColor;
}

void main (void){
  vec4 texColor = texture2D(texture, vertTexCoord.xy).rgba;
  gl_FragColor = vec4(Effect1(texColor));
}