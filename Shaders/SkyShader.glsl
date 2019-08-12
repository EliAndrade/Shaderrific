extern number height;
extern number factor;
extern number maximumHeight;

number darkness;
vec4 textureColor;

number lerp(number v0, number v1, number t) {
  return (1 - t) * v0 + t * v1;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	textureColor = Texel(texture, texture_coords);
	darkness =  min((height+(screen_coords[1]*factor))/maximumHeight, 1);
	textureColor[0] = darkness;
	textureColor[1] = darkness;
	textureColor[2] = darkness;
	return color*textureColor;
}
