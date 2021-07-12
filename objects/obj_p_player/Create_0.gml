/// @description Insert description here
// You can write your code in this editor

//Init the outline shader
outline_init();

outline_color = c_white;
//Player number assigned used to assign stats
//and controls to the player
p_number = 0;  
my_pad = global.p_pad[p_number];


//Movement code
can_jump = 1;
move_speed = 0.2;
max_speed = 5;
hfriction = 0.05;
gravity_direction = 270;

//Visual extras
alarm[0] = 240;

//Collisions structure that stores collision state for the step
collisions = {
	collision : 0,
	h_dir : 0,
	v_dir : 0
}

//Just a silly thing to play a fake game of tag
it = false;

//Stats 
max_hp = 1;
hp = 1;


