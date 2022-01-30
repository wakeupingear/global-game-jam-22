//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 u_color;

void main()
{
	vec4 base=texture2D( gm_BaseTexture, v_vTexcoord );
	base.a=sqrt(base.r);
	base.rgb= mix(base.rgb, u_color, 0.8);
    gl_FragColor = v_vColour * base;
}
