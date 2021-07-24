/// @description Insert description here
// You can write your code in this editor
if ( yspeed != 0 ){
	if ( place_meeting(x,y+yspeed+sign(yspeed),obj_block) ){
		old_yspeed = yspeed;
		yspeed = 0;	
		alarm[1] = 50;
	}
}

if ( xspeed != 0 ){
	if ( place_meeting(x+xspeed+sign(xspeed),y,obj_block) ){
		old_xspeed = xspeed;
		xspeed = 0;	
		alarm[1] = 10;
	}
}

x += xspeed;
y += yspeed;