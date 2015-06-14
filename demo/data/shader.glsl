//#version 140

uniform float iGlobalTime;
uniform vec2 iResolution;

// You can also use custom uniforms
// to pass any data to shader, 
// eg. values from Rocket.
//uniform float grid_rotation;
//uniform float grid_distort;
//uniform float grid_resolution;

mat3 rX(float a){return mat3(1,0,0,0,cos(a),-sin(a),0,sin(a),cos(a));}
mat3 rY(float a){return mat3(cos(a),0,sin(a),0,1,0,-sin(a),0,cos(a));}
mat3 rZ(float a){return mat3(cos(a),-sin(a),0,sin(a),cos(a),0,0,0,1);}


float cube( vec3 p, vec3 b )
{
    vec3 d = abs(p) - b;
    return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

float map( in vec3 p )
{
   float d = cube(p,vec3(1.0));

   float s = 1.0;
   for( int m=0; m<3; m++ )
   {
      vec3 a = mod( p*s, 2.0 )-1.0;
      s *= 3.0;
      vec3 r = abs(1.0 - 3.0*abs(a));

      float da = max(r.x,r.y);
      float db = max(r.y,r.z);
      float dc = max(r.z,r.x);
      float c = (min(da,min(db,dc))-1.0)/s;

      d = max(d,c);
   }

   return d;
}



vec3 rep(vec3 pos, float repeat) {
    vec3 rep = mod(pos, repeat) - 0.5*repeat;
    return rep;
}

float cubeField(vec3 pos) {
    return map(rep(pos, 4.0) * rY(iGlobalTime + (1.5+sin(iGlobalTime))*gl_FragCoord.x/iResolution.x));
}

float geometry( vec3 pos) { // object position
    
    //return cube((cubeField(pos) * rotateX(iGlobalTime)), vec3(1));
    return cubeField(pos * rX(iGlobalTime) * rY(0.2*iGlobalTime) * rZ(0.05*iGlobalTime));

}

vec3 rayMarch( vec3 camera, vec3 dir ) { // returns color RGB

    vec3 rayPos;
    float rayDist = 0.0;

    for (int i = 0; i < 64; ++i) // maximum step count
    {
        rayPos = camera + rayDist*dir;
        float curDist = geometry(rayPos);
        rayDist += curDist;
        if (curDist < 0.0001) {
            return vec3(
                    (1.0-(float(i)/64.0)), //R
                    (gl_FragCoord.x/iResolution.x + sin(iGlobalTime)), //G
                    (gl_FragCoord.y/iResolution.y + cos(0.2*iGlobalTime))  //B
                    ) / sqrt(rayDist +1.0); // fog
        }
    }

    return vec3(0.0); // default to returning black = background

}

void mainImage()
{

    vec3 camera = vec3(0,0,10);
    float aspect = iResolution.x / iResolution.y;
    vec2 uv = (2.0* gl_FragCoord.xy / iResolution.xy -1.0) * vec2(aspect, 1.0);
    vec3 dir = normalize(vec3(uv, -1));

    vec3 color = rayMarch(camera, dir);

    gl_FragColor = vec4(color, 1.0);
}

void main(void) {
    mainImage(void);
}