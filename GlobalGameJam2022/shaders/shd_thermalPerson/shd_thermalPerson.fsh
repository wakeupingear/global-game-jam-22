//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_color;

void main()
{
    gl_FragColor = v_vColour * mix(texture2D( gm_BaseTexture, v_vTexcoord ),vec4(u_color,u_color,u_color,1.0),0.8);
}
