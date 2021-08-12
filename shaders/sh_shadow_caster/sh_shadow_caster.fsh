//
// Simple passthrough fragment shader
//
//varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vScreenPos;
uniform vec4 iChannel;
uniform float iRadius;
uniform vec3 iLightInput;

void main()
{
	//vec2 dif=(v_vScreenPos);
	//float d=sqrt(dif.x*dif.x+dif.y*dif.y)/iRadius;
	gl_FragColor = iChannel;
}