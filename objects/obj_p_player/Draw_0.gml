/// @description draw player and effects
// You can write your code in this editor

draw_set_alpha(1);
draw_set_color(c_white);

if ( p_number == 0 ){
	outline_color = c_green;	
}
if ( p_number == 1 ){
	outline_color = c_red;	
}
if ( p_number == 2 ){
	outline_color = c_yellow;	
}
if ( p_number == 3 ){
	outline_color = c_blue;	
}



if ( it ){
	outline_color = c_white;	
}

if collisions.collision then outline_start(1,outline_color);

draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,c_white,1);

if collisions.collision then outline_end();

if ( alarm[0] ){
	draw_text_transformed(x - 15,y-40,"P" + string(p_number + 1),1,1,1);
}

draw_text_transformed(x - 15,y-20,collisions.h_dir ,1,1,1);
draw_text_transformed(x - 15,y-30,collisions.v_dir ,1,1,1);