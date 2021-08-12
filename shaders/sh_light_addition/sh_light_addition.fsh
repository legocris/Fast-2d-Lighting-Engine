//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 iChannel;

void main()
{
	vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord )*iChannel*(1.0+v_vColour.a*5.0);
	gl_FragColor = vec4( v_vColour.rgb*(colour.r+colour.g+colour.b+colour.a), 1.0);
}