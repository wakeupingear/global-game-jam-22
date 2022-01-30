//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_alpha;

void main()
{
	vec4 base=texture2D( gm_BaseTexture, v_vTexcoord );
    if (base.a==1.0) {
		base.a=u_alpha;
		gl_FragColor = v_vColour * base;
	}
}
