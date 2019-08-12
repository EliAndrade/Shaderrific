uniform sampler2D canvas; 

float metaball(vec2 FragCoord, vec3 circle) {
	return circle.z / length(FragCoord.xy-circle.xy);
}

uniform vec3 playerCircle = vec3(0., 0., 16.);
uniform vec2 translate = vec2(0., 0.);
uniform float factor = 1.75; //1 to 2
uniform vec3 circles[1024];

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {   
    float sum = metaball(screen_coords.xy, playerCircle);
    vec4 fragColor;
	
    if (length(gl_FragCoord.xy-playerCircle.xy) <= playerCircle.z*factor) {
        return Texel(canvas, texture_coords);
    }
    
    for (int i = 0; i < circles.length(); i++) {
    	vec3 circle = vec3(circles[i].xy+translate, circles[i].z);
    	
    	sum += metaball(screen_coords.xy, circle);
        if (length(screen_coords.xy-circle.xy) <= circle.z*factor) {
            return Texel(canvas, texture_coords);
        }
        
        if (sum > 1.) {
        	return Texel(canvas, texture_coords);
        }
        
        if (circle.z == 0) {
        	break; 
        }
    }
    
    
    if (sum > 1.) {
    	fragColor = Texel(canvas, texture_coords);
    }else {
    	fragColor = Texel(texture, texture_coords);
    }
    
    

    return fragColor;

}