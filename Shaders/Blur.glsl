uniform int amountX = 1; //Pixels
uniform int amountY = 1; //Pixels

vec4 effect(vec4 color, sampler2D texture, vec2 texture_coords, vec2 screen_coords) {
    float posx = texture_coords.x;
    float posy = texture_coords.y;
    
    
    vec4 vector;
   
    for (int y = -amountY; y <= amountY; y++) {
    	for (int x = -amountX; x <= amountX; x++) {
	        float modPosX = clamp(float(x) + screen_coords.x, 0.0, love_ScreenSize.x)/love_ScreenSize.x;
	        float modPosY = clamp(float(y) + screen_coords.y, 0.0, love_ScreenSize.y)/love_ScreenSize.y;
	        
			vec4 tex = Texel(texture, vec2(modPosX, modPosY));
	        
	        vector.r += tex.r;
	        vector.g += tex.g;
	        vector.b += tex.b;
        }
    }
    
  
    if (amountX > 0 && amountY > 0) {
    	vector.r /= float((amountX*2 + 1)*(amountY*2 + 1));
    	vector.g /= float((amountX*2 + 1)*(amountY*2 + 1));
    	vector.b /= float((amountX*2 + 1)*(amountY*2 + 1));
    	vector.a = Texel(texture, texture_coords).a;
    }else {
    	vector = Texel(texture, texture_coords);
    }
    return vector * color;
}