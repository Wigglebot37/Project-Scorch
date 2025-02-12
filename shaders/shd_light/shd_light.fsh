varying vec2 pos; // current pixel position
varying vec4 col;
varying vec2 v_vTexcoord;

uniform vec2 u_pos; // light source position

uniform float zz; // larger zz, larger light
uniform float u_str;
uniform float u_dir;
uniform float u_fov;
uniform sampler2D u_nmap;

#define PI 3.1415926538

void main() {
	vec2 dis = pos - u_pos;
	
	float str=1./(sqrt(dis.x*dis.x + dis.y*dis.y + zz*zz)-zz+1.-u_str); // strength of light is inverse distance
	float dir = radians(u_dir);
	float hfov = radians(u_fov)*0.5;
	
	if(hfov < PI) {
		float rad = atan(-dis.y,dis.x);
		float adis = abs(mod(rad+2.*PI,2.*PI) - dir);
		adis = min(adis,2.*PI - adis);
		str *= clamp((1.-adis/hfov)*5.,0.,1.);
	}
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
	vec3 norm = normalize(texture2D( u_nmap, v_vTexcoord ).rgb-0.5);
	vec3 lnorm = normalize(vec3(-dis.x,dis.y,32.));
	float norm_str = dot(norm,lnorm);
	float ref = pow(max(0.,reflect(-lnorm,norm).z),16.)*0.2;
	
    gl_FragColor = col * vec4(vec3(str*norm_str),1.)*frag + ref*col*str;
}
