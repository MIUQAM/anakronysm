#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertTexCoord;

uniform float intensity;
uniform float a;

void main(void) {
  int i = 0;
  int j= 0;
  vec4 sum = vec4(0.0);

  for( i=-5;i<5;i++) {
    for( j=-5;j<5;j++) {
        sum += texture2D( texture, vertTexCoord.st + vec2(j,i)*texOffset.st)*intensity;
    }
  }

  float alpha;

  if(sum.a == 0.0){
    alpha = 0.0;
  } else {
    alpha = a;
  }

  gl_FragColor = sum*sum+ vec4(texture2D( texture, vertTexCoord.st).rgb, alpha);
}
/*#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertTexCoord;

uniform float intensity;

#define T texture2D(texture,.5+(p.xy*=intensity))

void main() 
{
  vec3 resolution = vec3(1.0, 1.0, 0.0);
  vec3 p = vertTexCoord.xyz/resolution-.5;
  vec3 o = T.rgb;
  for (float i=0.;i<100.;i++) 
    p.z += pow(max(0.,.5-length(T.rgb)),2.)*exp(-i*.08);
  gl_FragColor=vec4(o*o+p.z,1);
}*/