/// @description Main control loop for the player
// 


//Query the global.p_pad array to get the gamepad id 
//assigned to this player object.  9 = keyboard 
my_pad = global.p_pad[p_number];

/////////////////
//Handle inputs
/////////////////

if ( global.pad_up[my_pad] || global.pad_d_up[my_pad] ){ 

	image_speed = 1;
}
if ( global.pad_right[my_pad] || global.pad_d_right[my_pad] ){
	if ( ! wall_set.state){
		xscale = 1;
	}
	image_speed = 1;
	xspeed += accelerate;
}
if ( global.pad_down[my_pad] || global.pad_d_down[my_pad] ){
	//Jump down through jump through blocks
	alarm[5] = 10;
	image_speed = 1;
}
if ( global.pad_left[my_pad] || global.pad_d_left[my_pad] ){
 	if ( ! wall_set.state){
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

if (  alarm[3] > 0   ){
	// Normal jumping
	//If jump state is ready OR the coyote timer 
	if ( jumping  || alarm[4] > 0 ){
		yspeed -= ground_set.jump_speed;
		//Fling off the wall if on the wall
		if ( wall_set.state ){
			xspeed += wall_set.xspeed;
			wall_set.state = false;
		}
		alarm[3] = 0;
		alarm[4] = 0;
	}
	//Double jumping
	//  we could not jump normally and Coyote timer is not going
	if ( ! jumping&& alarm[4] <= 0  && jump_count > 0 ){
		jump_count -= 1;
		yspeed = -ground_set.jump_speed;
		//Fling off the wall if on the wall
		if ( wall_set.state ){
			xspeed += wall_set.xspeed;
			wall_set.state = false;
		}
		alarm[3] = 0;
		alarm[4] = 0;
	}
	
}


//Limit horizontal and vertical speeds
yspeed = clamp(yspeed,-10,10);
xspeed = clamp(xspeed,-max_speed,max_speed);

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

//Apply gravity
yspeed += gravity_speed;

var col_xspeed = 0;
var col_yspeed = 0;
if ( collisions.col_hblock ){
	col_xspeed = collisions.col_hblock.xspeed;
	col_yspeed = collisions.col_hblock.yspeed;	
}
if ( collisions.col_vblock ){
	col_xspeed = collisions.col_vblock.xspeed;
	col_yspeed = collisions.col_vblock.yspeed;	
}

//Keep moving platforms from sticking you to a the wall
//What they will do is negate your xspeed, collide you, and that will set your xspeed to 0 again repeat rinse
if ( abs(xspeed) > 0 && abs(col_xspeed) >= abs(xspeed) && collisions.col_hblock){
	if ( ! place_meeting(x+abs(col_xspeed),y,obj_block) ){
		xspeed+=abs(-col_xspeed);
	}
}

///
// "Solid" wall collisions and slopes
collisions = collideWall(xspeed+col_xspeed,yspeed+col_yspeed,5,obj_block,obj_block_jump_through);
if ( collisions.collision ){
    //If you collided horizontally
	if ( ( collisions.col_right || collisions.col_left )  ) {
		// If you didn't JUST jump. Jumping up slopes will sometimes collide horizontally,
		// but you really don't want to reset horizontal movement.
		if ( alarm[3] <= 0 ){
			xspeed = 0;
		}
		if ( collisions.col_hblock ){
			// Temporary debug testing stuff ( next 2 lines 
			if collisions.col_right then collisions.col_hblock.col_left = true else collisions.col_hblock.col_right = true;
			collisions.col_hblock.alarm[0] = 15;
		}
	}
	// STOP the yspeed if you collided vertically
	if ( collisions.col_top || collisions.col_bottom  ) {
		// Stop vertical movement
		yspeed = 0;
		if ( collisions.col_vblock ){
			// Temporary debug testing stuff ( next 2 lines )
			if collisions.col_top then collisions.col_vblock.col_bottom = true else collisions.col_vblock.col_top = true;
			collisions.col_vblock.alarm[0] = 15;
		}
	}	
}

//Falling
if ( ! collisions.col_bottom ){
	//We WERE on the ground no we are not.
	//Set the timer to disallow jumping
	if ( ground_set.state ){
		alarm[4] = coyote_timer;
	}
	//Turn on gravity cause you are floating in the air :)
	gravity_speed = air_set.grav;
	//Set state to not on the ground
	ground_set.state = false;
	//Set jump state to state not ready ( if alarm[3] > 0 you can still jump )
	//maybe move to alarm[3]?
	jumping= false;
}  //Hit the ground
else {
	//Reset the jump counter if just landing
	jump_count = jump_count_max;
	jumping= true;
	ground_set.state = true;
}


/////////////////////////////
// State and Sprite Handling
/////////////////////////////
sprite_index = my_sprites.idle;

//// On the ground
if ( ground_set.state) {
	if  ( xspeed != 0 ){
		sprite_index = my_sprites.move;
	}
	//Set movement properties 
	hfriction = ground_set.hfriction;
	accelerate = ground_set.accelerate;
	gravity_speed= ground_set.grav;
	//Reset wall state
	wall_set.state = false;
}
//// In the air
if ( ! ground_set.state){

	// Jumping up
	if( yspeed <= 0 ){
	sprite_index = my_sprites.jump_up;
	}
	// Moving down in the air 
	if ( yspeed > 0 ){
		sprite_index = my_sprites.jump_down;
	}
	//Set movement properties while in air
	hfriction = air_set.hfriction;
	accelerate = air_set.accelerate;
	gravity_speed= air_set.grav;	

	//Reset wall state
	wall_set.state = false;
	// Wall Slide :) 
	if ( ( collisions.col_right || collisions.col_left ) ){
		alarm[6] = 10;
		if (collisions.col_right){
			wall_set.xspeed = -2.5;
			xscale = 1
		}
		else {
			wall_set.xspeed = 2.5;
			xscale = -1
		}
	}
	if ( alarm[6] > 0 ){
		jump_count = jump_count_max;		
		jumping= true;
		wall_set.state = true;
		//SLIIIIIIDDDDDDIIIIINNNGGGGG
		if ( yspeed > 0 ){
			hfriction = wall_set.hfriction;
			accelerate = wall_set.accelerate;
			gravity_speed= wall_set.grav;
			if yspeed > wall_set.max_yspeed then yspeed = wall_set.max_yspeed;
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