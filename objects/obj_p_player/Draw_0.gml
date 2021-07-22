/// @description draw player and effects
// You can write your code in this editor

draw_set_alpha(1);
draw_set_color(c_white);

if ( p_number == 0 ){
	outline_color = c_blue;	
}
if ( p_number == 1 ){
	outline_color = c_red;	
}
if ( p_number == 2 ){
	outline_color = c_yellow;	
}
if ( p_number == 3 ){
	outline_color = c_green;	
}


if ( global.debug ){
	draw_set_color(c_white);
	draw_line(bbox_left,bbox_top,bbox_right,bbox_top);
	draw_line(bbox_left,bbox_bottom,bbox_right,bbox_bottom);
	draw_line(bbox_left,bbox_top,bbox_left,bbox_bottom);
	draw_line(bbox_right,bbox_top,bbox_right,bbox_bottom);
}	

if ( it ){
	outline_color = c_white;	
}

if 1 == 1 then outline_start(1,outline_color);

draw_sprite_ext(sprite_index,-1,x,y,xscale,yscale,angle,c_white,1);

if 1 == 1 then outline_end();

if ( alarm[0] ){
	draw_text_transformed(x - 15,y-40,"P" + string(p_number + 1),1,1,1);
}


if global.debug then draw_text_transformed(x + 15,y-30,y ,1,1,1);
if global.debug then draw_text_transformed(x + 15,y-20,alarm[3] ,1,1,1);

