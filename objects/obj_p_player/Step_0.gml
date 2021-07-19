/// @description Main control loop for the player
// 


//Query the global.p_pad array to get the gamepad id 
//assigned to this player object.  9 = keyboard 
my_pad = global.p_pad[p_number];

/////////////////
//Handle inputs
/////////////////
if ( global.pad_up[my_pad] ){ 

	image_speed = 1;
}
if ( global.pad_right[my_pad] ){
    xscale = 1;
	image_speed = 1;
	
	xspeed += accelerate;
}
if ( global.pad_down[my_pad] ){

	image_speed = 1;
}
if ( global.pad_left[my_pad] ){
    xscale = -1;
	image_speed = 1;
	
	xspeed -= accelerate;
}

// Jump timer start.
// If this timer is running when you CAN jump, you will jump.
if ( global.pad_b2_pressed[my_pad] ){
	alarm[3] = jump_timer;
}
//If jump timer is going and jump state is ready OR the coyote timer and jump timer are good to go for a jump
if ( ( jump_state.state || alarm[4] > 0 ) && alarm[3] > 0   ){
	yspeed = -ground_state.jump_speed;
	
	if ( wall_state.state ){
		xspeed = wall_state.xspeed*sign(-xspeed);
	}
	alarm[0] = 0;
	alarm[4] = 0;
}

/////////////////
//Shooting
/////////////////
if ( global.pad_b1_pressed[my_pad] && alarm[1] <= 0 ){
	var my_b = instance_create_layer(x+lengthdir_x(20,direction),y+lengthdir_y(20,direction),"Instances",obj_player_bullet);
	my_b.direction = direction;
	my_b.speed = 4;
	my_b.friction = -0.2;
	my_b.image_angle = image_angle;
	my_b.creator = id;
	alarm[1] = 20;
	//Screen shake

}

//Limit horizontal and vertical speeds
clamp(yspeed,-10,10);
clamp(xspeed,-3,3);

//Slow horizontal movement based on the current friction
if ( xspeed > 0 ){
	xspeed -= hfriction;
	if ( xspeed < 0 ){
		xspeed = 0;
	}
}
if ( xspeed < 0 ){
	xspeed += hfriction;
	if ( xspeed > 0 ){
		xspeed = 0;
	}
}
 
//////////////////////////
//Movement and collision
//////////////////////////
collisions = collide_wall(xspeed,yspeed,obj_block);
if ( collisions.collision ){
    //If you collided horizontally
	if ( collisions.col_right || collisions.col_left ) {
		//CONSIDER moving slope code to end of collide_wall function and just return if collision occured or not...
		//Check for slopes we can navigate 
		var _slope_collide = collide_slopes(xspeed,5,obj_block);
		//Stop movement and potential movement if we end the testing of slopes in a collided state.
		if ( _slope_collide ){
			xspeed = 0;
		}
		//Temporary debug testing stuff ( next 2 lines )
		if collisions.col_right then collisions.col_hblock.col_left = true else collisions.col_hblock.col_right = true;
		collisions.col_hblock.alarm[0] = 15;
	}
	//STOP the yspeed if you collided vertically AND stop gravity_speed if you hit the floor 
	if ( collisions.col_top || collisions.col_bottom  ) {
		//Stop movement
		yspeed = 0;
		//Temporary debug testing stuff ( next 2 lines )
		if collisions.col_top then collisions.col_vblock.col_bottom = true else collisions.col_vblock.col_top = true;
		collisions.col_vblock.alarm[0] = 15;
	}	
}

// Going down slopes
/* BROKEN AND BLECH
if ( ! collisions.collision and yspeed >= 0){
	//Test if their is a slope below us 
	if ( place_meeting(x+xspeed,y+10,obj_block_slope_32x32) ){
		while( !place_meeting(x,y+1,obj_block_slope_32x32) && !place_meeting(x,y+1,obj_block) ){
			y += 1;	
			collisions.col_bottom = true;
			collisions.collision = true;
			jump_state.state = 1;
			ground_state.state= 1;
		}
	}
}*/

//Move normally if not colliding
if ( ! ( collisions.col_right || collisions.col_left ) ) {
	//Move player normally if no collsion detected
	x += xspeed;

}
if ( ! ( collisions.col_top || collisions.col_bottom ) ) {
	yspeed += gravity_speed;
	y += yspeed;	
}
	

//Falling
if ( !place_meeting(x,y+1,obj_block)){
	//We WERE on the ground no we are not.
	//Set the timer to disallow jumping
	if ( ground_state.state ){
		alarm[4] = coyote_timer;
	}
	//Turn on gravity cause you are floating in the air :)
	gravity_speed= air_state.grav;
	//Set state to not on the ground
	ground_state.state= 0;
	//Set jump state to state not ready ( if alarm[0] > 0 you can still jump )
	//maybe move to alarm[0]?
	jump_state.state = 0;
}
//On ground!
if ( place_meeting(x,y+1,obj_block) ){
	jump_state.state = 1;
	ground_state.state= 1;
}


// State and Sprite Handling
sprite_index = my_sprites.idle;

//// On the ground
if ( ground_state.state) {
	if  ( xspeed != 0 ){
		sprite_index = my_sprites.move;
	}
	//Set movement properties 
	hfriction = ground_state.hfriction;
	accelerate = ground_state.accelerate;
	gravity_speed= ground_state.grav;
	//Reset wall state
	wall_state.state = 0;
}
//// In the air
if ( !ground_state.state){
	//Set movement properties while in air
	hfriction = air_state.hfriction;
	accelerate = air_state.accelerate;
	gravity_speed= air_state.grav;
	
	// Jumping up
	if( yspeed <= 0 ){
	sprite_index = my_sprites.jump_up;
	}
	// Moving down in the air 
	if ( yspeed > 0 ){
		sprite_index = my_sprites.jump_down;
	}
	//Reset wall state
	wall_state.state = 0;
	// Wall Slide :) 
	if ( ( collisions.col_right || collisions.col_left ) && yspeed > 0 ){
		wall_state.state = 1;
		hfriction = wall_state.hfriction;
		accelerate = wall_state.accelerate;
		jump_state.state = 1;
		gravity_speed= wall_state.grav;
		if yspeed > wall_state.max_yspeed then yspeed = wall_state.max_yspeed;
		sprite_index = my_sprites.wall;
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

//set_sprites_platformer();