#define PROCESSING_TEXTURE_SHADER
// Scene buffer
uniform sampler2D texture; 
// Swirl effect parameters
uniform float radius;
uniform float angle;
uniform vec2 center;

vec4 PostFX(sampler2D tex, vec2 uv)
{

  vec2 texSize = vec2(480.0, 360.0);
  vec2 tc = uv * texSize;
  tc -= center;
  float dist = length(tc);
  if (dist < radius) 
  {
    float percent = (radius - dist) / radius;
    float theta = percent * percent * angle * 8.0;
    float s = sin(theta);
    float c = cos(theta);
    tc = vec2(dot(tc, vec2(c, -s)), dot(tc, vec2(s, c)));
  }
  tc += center;
  vec3 color = texture2D(texture, tc / texSize).rgb;
  return vec4(color, 1.0);
}

void main (void)
{
  vec2 uv = gl_TexCoord[0].st;
  gl_FragColor = PostFX(texture, uv);
}