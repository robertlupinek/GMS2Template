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
	if ( ! wall_state.state){
		xscale = 1;
	}
	image_speed = 1;
	xspeed += accelerate;
}
if ( global.pad_down[my_pad] ){
	//Jump down through jump through blocks
	alarm[5] = 10;
	image_speed = 1;
}
if ( global.pad_left[my_pad] ){
 	if ( ! wall_state.state){
		xscale = -1;
	}
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
	//y -= 5;
	yspeed = -ground_state.jump_speed;
	if ( wall_state.state ){
		xspeed += wall_state.xspeed;
		wall_state.state = false;
	}
	alarm[3] = 1;
	alarm[4] = 0;
}


//Limit horizontal and vertical speeds
yspeed = clamp(yspeed,-10,10);
xspeed = clamp(xspeed,-3,3);

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

///
// "Solid" wall collisions and slopes
collisions = collide_wall(xspeed,yspeed,5,obj_block,obj_block_jump_through);
if ( collisions.collision ){
    //If you collided horizontally
	if ( ( collisions.col_right || collisions.col_left )  ) {
		// If you didn't JUST jump. Jumping up slopes will sometimes collide horizontally,
		// but you really don't want to reset horizontal movement.
		if ( alarm[3] <= 0 ){
			xspeed = 0;
		}
		// Temporary debug testing stuff ( next 2 lines 
		if ( collisions.col_hblock ){
			if collisions.col_right then collisions.col_hblock.col_left = true else collisions.col_hblock.col_right = true;
			collisions.col_hblock.alarm[0] = 15;
		}
	}
	// STOP the yspeed if you collided vertically
	if ( collisions.col_top || collisions.col_bottom  ) {
		// Stop vertical movement
		yspeed = 0;
		// Temporary debug testing stuff ( next 2 lines )
		if ( collisions.col_vblock ){
			if collisions.col_top then collisions.col_vblock.col_bottom = true else collisions.col_vblock.col_top = true;
			collisions.col_vblock.alarm[0] = 15;
		}
	}	
}

// Move normally if not colliding
if ( ! ( collisions.col_right || collisions.col_left ) ) {
	//Move player according to it's xspeed and the xspeed of any moving platforms you are in contact with.
	x += xspeed + collisions.col_xspeed;;
}
if ( ! ( collisions.col_top || collisions.col_bottom ) ) {
	// Add the current gravity speed before 
	yspeed += gravity_speed;
	//Move player according to it's yspeed and the yspeed of any moving platforms you are in contact with.
	y += yspeed + collisions.col_yspeed;	
}

//Falling
if ( ! collisions.col_ground ){
	//We WERE on the ground no we are not.
	//Set the timer to disallow jumping
	if ( ground_state.state ){
		alarm[4] = coyote_timer;
	}
	//Turn on gravity cause you are floating in the air :)
	gravity_speed = air_state.grav;
	//Set state to not on the ground
	ground_state.state = 0;
	//Set jump state to state not ready ( if alarm[3] > 0 you can still jump )
	//maybe move to alarm[3]?
	jump_state.state = 0;
} else {
	jump_state.state = 1;
	ground_state.state = 1;
}


/////////////////////////////
// State and Sprite Handling
/////////////////////////////
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

	// Jumping up
	if( yspeed <= 0 ){
	sprite_index = my_sprites.jump_up;
	}
	// Moving down in the air 
	if ( yspeed > 0 ){
		sprite_index = my_sprites.jump_down;
	}
	//Set movement properties while in air
	hfriction = air_state.hfriction;
	accelerate = air_state.accelerate;
	gravity_speed= air_state.grav;	
	
	//Reset wall state
	wall_state.state = false;
	// Wall Slide :) 
	if ( ( collisions.col_right || collisions.col_left ) ){
		alarm[6] = 10;
		if (collisions.col_right){
			wall_state.xspeed = -2.5;
			xscale = 1
		}
		else {
			wall_state.xspeed = 2.5;
			xscale = -1
		}
	}
	if ( alarm[6] > 0 ){
		wall_state.state = 1;
		jump_state.state = 1;
		//SLIIIIIIDDDDDDIIIIINNNGGGGG
		if ( yspeed > 0 ){
			hfriction = wall_state.hfriction;
			accelerate = wall_state.accelerate;
			gravity_speed= wall_state.grav;
			if yspeed > wall_state.max_yspeed then yspeed = wall_state.max_yspeed;
			sprite_index = my_sprites.wall;
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