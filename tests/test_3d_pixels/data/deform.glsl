#define PROCESSING_TEXTURE_SHADER
uniform vec2 resolution; 
varying vec4 vertTexCoord;
uniform sampler2D tex; 

void main(void) { 
	vec2 p = -1.0 + 2.0 * vertTexCoord.xy / resolution.xy;
	vec2 uv; 
	float a = atan(p.y,p.x) / (2.0*3.1416);
	float r = sqrt(dot(p,p))/sqrt(2.0);
	uv.x = r;
	uv.y = a+r;
	vec3 col = texture2D(tex,uv).xyz;
	gl_FragColor = vec4(col,1.0);
} 