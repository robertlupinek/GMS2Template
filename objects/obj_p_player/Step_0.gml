/// @description Main control loop for the player
// 


//Query the global.p_pad array to get the gamepad id 
//assigned to this player object.  9 = keyboard 
my_pad = global.p_pad[p_number];

image_speed = 0;


//Motion 
if ( global.pad_up[my_pad] ){

	image_speed = 1;
}
if ( global.pad_right[my_pad] ){
    image_xscale = 1;
	image_speed = 1;
	
	hspeed += 0.1;
}
if ( global.pad_down[my_pad] ){

	image_speed = 1;
}
if ( global.pad_left[my_pad] ){
    image_xscale = -1;
	image_speed = 1;
	
	hspeed -= 0.1;
}

if ( !place_meeting(x,y + 1, obj_block) ){
	gravity = 0.1
}





/*
//If stuck inside a brick

*/

if ( global.pad_b2[my_pad] ){
	if ( can_jump == 1 ){
		vspeed = -4;
		can_jump = 0;
	}
}


//Shooting
if ( global.pad_b1[my_pad] && alarm[1] <= 0 ){
	var my_b = instance_create_layer(x+lengthdir_x(20,direction),y+lengthdir_y(20,direction),"Instances",obj_player_bullet);
	my_b.direction = direction;
	my_b.speed = 4;
	my_b.friction = -0.2;
	my_b.image_angle = image_angle;
	my_b.creator = id;
	alarm[1] = 20;
	//Screen shake

}


//Speed controls
clamp(vspeed,-10,10);
clamp(hspeed,-5,5);

if ( can_jump == 1 ){
	hfriction = 0.06;
}
else {
	hfriction = 0.04;
}


if ( hspeed > 0 ){
	hspeed -= hfriction;
	if ( hspeed < 0 ){
		hspeed = 0;
	}
}
if ( hspeed < 0 ){
	hspeed += hfriction;
	if ( hspeed > 0 ){
		hspeed = 0;
	}
}
//Handle collisions
collisions = collide_wall(hspeed,vspeed,obj_block)
if ( collisions.collision ){
	//Horizontal collisions
	if ( collisions.h_dir != 0 ) {
		hspeed = 0;
	}
	//Vertical collisions	
	if ( collisions.v_dir != 0  ) {
		vspeed = 0;
		// Collision down
		if ( collisions.v_dir == 1 ){
			//Fractional values of y can get a fellow stuck in the floor
			y = y
			gravity = 0;
			can_jump = 1;
		}
	}	
}


//EXPLODE!!!!
if ( hp <= 0 ){
	with(obj_camera){
		alarm[0] = 15;
	}
	repeat(40){
		instance_create_layer(x-30+random(60),y-30+random(60),"Instances",obj_paricle_a);	
	}
	instance_destroy();
}

set_sprites_platformer();