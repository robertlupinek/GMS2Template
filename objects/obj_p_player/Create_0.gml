/// @description Insert description here
// You can write your code in this editor

//Init the outline shader
outline_init();




ground_state= {
	state		: 0,
	hfriction	: 0.06,
	vfriction	: 0,
	accelerate : 0.1,
	grav		: 0,
	jump_speed	: 4
}
air_state =  {
	state		: 0,
	hfriction	: 0.02,
	vfriction	: 0,
	accelerate : 0.05,
	grav		: 0.1,
	jump_speed	: 4
}
wall_state =  {
	state		: 0,
	hfriction	: 0,
	vfriction	: 0,
	accelerate : 0.1,
	max_yspeed	: 1,
	grav		: 0.05,
	jump_speed	: 4,
	xspeed		: 1,
}

jump_state = {
	state : 0	
}


my_sprites= {
	move		: spr_f_player_move,
	idle		: spr_f_player_stand,
	wall		: spr_f_player_wall,
	idle		: spr_f_player_stand,
	jump_up		: spr_f_player_jump_up,
	jump_down	: spr_f_player_jump_down,
}


outline_color = c_white;
//Player number assigned used to assign stats
//and controls to the player
p_number = 0;  
my_pad = global.p_pad[p_number];

//Sprites
xscale = 1;
yscale = 1;
angle = 0;

//Movement code
jump_timer = 10;
coyote_timer = 10;
accelerate = ground_state.accelerate;
max_speed = 3;
hfriction = 0.05;
xspeed = 0;
yspeed = 0;
gravity_speed = 0;

gravity_direction = 270;

//Visual extras
alarm[0] = 240;

//Collisions structure that stores collision state for the step
collisions = {
	collision : false,
	col_right : false,
	col_left : false,
	col_top : false,
	col_bottom : false,		
	free_x : 0,
	free_y : 0,
}

//Just a silly thing to play a fake game of tag
it = false;

//Stats 
max_hp = 1;
hp = 1;


