#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;

uniform float intensity;

#define T texture2D(texture,.5+(p.xy*=.992))

void main() 
{
  vec3 resolution = vec3(1.0, 1.0, 0.0);
  vec3 p = vertTexCoord.xyz/resolution-.5;
  vec3 o = T.rbb;
  for (float i=0.;i<100.;i++) 
    p.z += pow(max(0.,.5-length(T.rg)),2.)*exp(-i*.08);
  gl_FragColor=vec4(o*o+p.z,1);
}