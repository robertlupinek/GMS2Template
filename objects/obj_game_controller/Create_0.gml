/// @description Insert description here
// You can write your code in this editor

game_start = 0;  //If the game has started or not
global.p_pad = []; //Unassign game pads

//Create the camera object
camera = instance_create_depth(x,y,-100000,obj_camera);
camera.target = obj_game_controller;
//Create the input controller
controls = instance_create_depth(x,y,-100000,obj_input_controls);

alarm[0] = 2;