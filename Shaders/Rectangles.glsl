uniform float value; //0 to 1

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 texturecolor = Texel(texture, texture_coords);	
    vec4 c;
    if (mod(floor(texture_coords.y*100), 2) == 1) {
    	c = vec4(step(texture_coords.x, value));
    }else {
    	c = vec4(step(1-texture_coords.x, value));
    }
    
	return c*texturecolor*color;
}
