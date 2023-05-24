

function outlineShaderInit() {
	uni_size = shader_get_uniform(sh_outline, "u_size");
	uni_color = shader_get_uniform(sh_outline, "u_color");
	uni_texel = shader_get_uniform(sh_outline, "u_texel");
}

/// @paremeter _size = thickness
/// @parameter _color - color

function outlineShaderStart(_size,_color) {
	
	shader_set(sh_outline);
	
	//Get the texture and it's height and width
	var _texture = sprite_get_texture(sprite_index, image_index);
	var _w = texture_get_texel_width(_texture);
	var _h = texture_get_texel_height(_texture);
	shader_set_uniform_f(uni_texel, _w, _h);		
	shader_set_uniform_f(uni_size, _size);
	shader_set_uniform_f(uni_color, color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255);
}

function outlineShaderEnd() {
	shader_reset();
}

