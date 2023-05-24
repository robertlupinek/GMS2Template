//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_size;
uniform vec3 u_color;
uniform vec2 u_texel;


void main()
{
	
    vec4 _new_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec2 _pixel_size = u_texel * u_size;
	
	if ( texture2D(gm_BaseTexture,v_vTexcoord).a <= 0.0 ){
		float alpha = 0.0;
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - _pixel_size.x, v_vTexcoord.y ) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + _pixel_size.x, v_vTexcoord.y ) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - _pixel_size.y ) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + _pixel_size.y ) ).a);
		
	    alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - _pixel_size.x, v_vTexcoord.y - _pixel_size.y) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + _pixel_size.x, v_vTexcoord.y + _pixel_size.y ) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - _pixel_size.x, v_vTexcoord.y - _pixel_size.y ) ).a);
		alpha = max(alpha, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + _pixel_size.x, v_vTexcoord.y + _pixel_size.y ) ).a);
		
		
		if (alpha > 0.0) {
			_new_color = vec4(u_color,1.0);
		}
    }
	gl_FragColor = _new_color;
}