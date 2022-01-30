//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 u_color;
uniform float u_alpha;

void main()
{
	vec4 base = texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor=vec4(u_color.r,u_color.g,u_color.b,base.a);
}
