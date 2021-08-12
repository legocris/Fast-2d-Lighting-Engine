//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
//varying vec4 v_vColour;
//varying vec2 v_vScreenPos;
//const vec2 iLightInput=vec2(128.0, 128.0); //x, y, radius
uniform vec4 iChannel;
//uniform float iRadius;

void main()
{
	vec4 colour=texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = iChannel*(colour.r+colour.g+colour.b)/3.0;
}