/// @description Draw bbox boundaries

draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,c_white,0.8);

if ( global.debug ){
	draw_set_alpha(0.8);
	if  col_top = true and alarm[0] then draw_line_width_color(bbox_left,bbox_top,bbox_right,bbox_top,3,c_white,c_white);
	if  col_bottom = true and alarm[0] then draw_line_width_color(bbox_left,bbox_bottom,bbox_right,bbox_bottom,3,c_white,c_white);
	if  col_left = true and alarm[0] then  draw_line_width_color(bbox_left,bbox_top,bbox_left,bbox_bottom,3,c_white,c_white);
	if  col_right = true and alarm[0] then draw_line_width_color(bbox_right,bbox_top,bbox_right,bbox_bottom,3,c_white,c_white);
}	
