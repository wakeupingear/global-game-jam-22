varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_quality;

void main()
{
    if (u_quality>=1.0) 
	{
		vec4 Color=vec4(0.0,0.0,0.0,0.0);
		float v;
		for( float i=0.0;i<1.0;i+=1.0/u_quality )
	    {
		        v = 0.9+i*0.1;//convert "i" to the 0.9 to 1 range
		        Color += texture2D( gm_BaseTexture, v_vTexcoord*v+0.5-0.5*v);
		}
		Color /= float(u_quality);
		gl_FragColor =  Color *  v_vColour;
	}
	else gl_FragColor=v_vColour*texture2D(gm_BaseTexture,v_vTexcoord);
}