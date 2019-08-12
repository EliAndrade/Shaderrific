//Define what to return
#define CASE_GREATER Texel(canvas, texture_coords)
#define CASE_LOWER   Texel(texture, texture_coords)

float metaball(vec2 FragCoord, vec3 circle) {
	return circle.z / length(FragCoord.xy-circle.xy);
}

//Define circles
/*
 * Circles are defined as (x, y, radius)
 * Radius means where of the circle will be always 
 * >= 1
 */
uniform vec3 playerCircle = vec3(0., 0., 16.);
uniform vec3 circles[1024];

//Canvas for the switch effect
uniform sampler2D canvas; 

//Translation of the camera
uniform vec2 translate = vec2(0., 0.);

//Time for the "breathing" circle effect
uniform float time;
uniform float minSize = 0.8; 
uniform float maxSize = 1.;

/* Factor is manipulation of the minimum radius 
 * of circle (where value will be always >= 1),
 * without changing the area of effect of the circle
 * 
 *  (1 <= factor <= 2)
 */
uniform float factor = 1.75;


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {   
    float size = mix(minSize, maxSize, (1.+sin(time))/2.);
    vec3 playerCircle = vec3(playerCircle.xy, playerCircle.z*size);
    
    //Check if is inside the circle of player
    if (length(gl_FragCoord.xy-playerCircle.xy) <= playerCircle.z*factor) {
        return CASE_GREATER;
    }
    
    for (int i = 0; i < circles.length(); i++) {
    	vec3 circle = vec3(circles[i].xy+translate, circles[i].z*size);
    	
    	//Finished array
        if (circle.z == 0) {
        	break; 
        }
    	
        //Check if circle is visible
    	if (circle.x-circle.z > love_ScreenSize.x ||
    		circle.x+circle.z < 0.   ||
			circle.y-circle.z > love_ScreenSize.y ||
			circle.y+circle.z < 0.
    	) {
    		continue;
    	}
    	
    	//Is already inside the circle
        if (length(screen_coords.xy-circle.xy) <= circle.z*factor) {
            return CASE_GREATER;
        }
    	
        
        //Test if the sums is greater than the expected
    	float sum = metaball(screen_coords.xy, playerCircle);
    	sum += metaball(screen_coords.xy, circle);
        if (sum > 1.) {
        	return CASE_GREATER;
        }
    }
    
    
    return CASE_LOWER;
}