uniform float value; //0 to 1
uniform float maxDiv = 100;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	float div = love_ScreenSize.x/ceil(maxDiv*(1-value));
	vec4 frag = Texel(texture, floor(texture_coords*div)/div);
	return frag*color;
}
