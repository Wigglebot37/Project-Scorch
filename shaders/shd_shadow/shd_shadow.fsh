varying float tdis;
varying float ldis;

void main() {
	float str = (1. - abs(tdis-0.5)*2./ldis)*5.; // soft shadow strength
    gl_FragColor = vec4(str);
}
