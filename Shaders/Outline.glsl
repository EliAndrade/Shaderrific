vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(texture, texture_coords);
    bool isCandidate = texcolor.a == 0.;
    bool found = false;

    
    if (isCandidate) {
        for (int y = -1; y <= 1; y++) {
            for (int x = -1; x <= 1; x++) {
                if (y != 0 && x != 0) {
                    vec2 coord = clamp(
                    	vec2(
                    			((texture_coords.x*love_ScreenSize.x)+x)/love_ScreenSize.x,
								((texture_coords.y*love_ScreenSize.y)+y)/love_ScreenSize.y
						)
                    , 0., 1.);                    
                    
                    if (Texel(texture, coord).a > 0.) {
                        found = true;
                        break;
                    } 
                }
            }
        }
    }
    
    if (found) {
    	return vec4(1.);
    }else {
    	return vec4(vec3(0.), 1.);
    }
}