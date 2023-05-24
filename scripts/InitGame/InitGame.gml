function setupGame() {

	///Camera configuration
	//Camera zoom level
	global.camera_zoom = 2;
	
	// Current song
	global.song = -1;
	global.song_id = -1;	

    //Type of game to demo
	global.game_type = "platformer"
	
	global.max_players = 4;
	
	global.debug = false;

	///Player Stats 
	global.p1 = {
		max_hp : 3
	}
	global.p2 = {
		max_hp : 3
	}
	global.p3 = {
		max_hp : 3
	}
	global.p4 = {
		max_hp : 3
	}	

	///Save game configuration
	global.save_file_name = "saved_game.json";
	
	global.game_state = {
		p1 : global.p1,
		p2 : global.p2,
		p3 : global.p3,
		p4 : global.p4,		
		save_room : "rm_test_room"
	}

	//Buttons 2d array variable
	global.buttons = 0;
	//Variables used to nagivate the 2d array
	global.button_x = 0;
	global.button_y = 0;
	//Globals for game controls

	global.any_down = false;
	global.any_up = false;
	global.any_left = false;
	global.any_right = false;
	global.any_b1 = false;
	global.any_b2 = false;
	global.any_b3 = false;
	global.any_b4 = false;
	global.any_b5 = false;
	global.any_b6 = false;
	global.any_start = false;
	global.any_d_down = false;
	global.any_d_up = false;
	global.any_d_left = false;
	global.any_d_right = false;		

	global.any_down_pressed = false;
	global.any_up_pressed = false;
	global.any_left_pressed = false;
	global.any_right_pressed = false;
	global.any_b1_pressed = false;
	global.any_b2_pressed = false;
	global.any_b3_pressed = false;
	global.any_b4_pressed = false;
	global.any_b5_pressed = false;
	global.any_b6_pressed = false;
	global.any_start_pressed = false;
	global.any_d_down_pressed = false;
	global.any_d_up_pressed = false;
	global.any_d_left_pressed = false;
	global.any_d_right_pressed = false;		

	///Player assigned to the pad
	//Each indice represents a player
	//Set the player to keyboard by setting p_pad[x] = 8, where index x is the player.
	global.p_pad = [];

	//Controller / gamepad
	// Gamepad 8 is the keyboard :)
	for ( var _pads = 0; _pads <= 8; _pads++;){
	
		global.pad_down[_pads] = false;
		global.pad_up[_pads]  = false;
		global.pad_left[_pads]  = false;
		global.pad_right[_pads]  = false;
		global.pad_b1[_pads]  = false;
		global.pad_b2[_pads]  = false;
		global.pad_b3[_pads]  = false;
		global.pad_b4[_pads]  = false;
		global.pad_b5[_pads]  = false;
		global.pad_b6[_pads]  = false;
		global.pad_start[_pads]  = false;
		global.pad_d_down[_pads] = false;
		global.pad_d_up[_pads] = false;
		global.pad_d_left[_pads] = false;
		global.pad_d_right[_pads] = false;			
	
		global.pad_down_pressed[_pads] = false;
		global.pad_up_pressed[_pads]  = false;
		global.pad_left_pressed[_pads]  = false;
		global.pad_right_pressed[_pads]  = false;
		global.pad_b1_pressed[_pads]  = false;
		global.pad_b2_pressed[_pads]  = false;
		global.pad_b3_pressed[_pads]  = false;
		global.pad_b4_pressed[_pads]  = false;
		global.pad_b5_pressed[_pads]  = false;
		global.pad_b6_pressed[_pads]  = false;
		global.pad_start_pressed[_pads]  = false;
		global.pad_d_down_pressed[_pads] = false;
		global.pad_d_up_pressed[_pads] = false;
		global.pad_d_left_pressed[_pads] = false;
		global.pad_d_right_pressed[_pads] = false;			

	}

	///Font configuration
	//Fonts
	global.font_blue = font_add_sprite(spr_blue_font,ord("!"),true,1);
	global.font_white = font_add_sprite(spr_white_font,ord("!"),true,-4);
	global.font_red = font_add_sprite(spr_red_font,ord("!"),true,1);
	global.font_small = font_add_sprite(spr_small_font,ord("!"),true,1);
	global.font_score = font_add_sprite(spr_score_font,ord("!"),true,1);

	show_debug_message("Game Setup Complete!")
	//Got to next room
	room_goto_next();

}


/// @function	spawnPlayer(_x,_y
/// @desc		Spawn player at coordinates, assign controls, andset default stats. 
///	@param		{_x} _x	X Coordinate to spawn player
///	@param		{_y} _y	Y Coordinate to spawn player
function spawnPlayer(_x,_y){

	//Triggers if a new input devices "activation" button was pressed
	if ( assignInput(global.max_players) ){
		if ( global.game_type == "shooter" ){
			var new_player = instance_create_layer(_x,_y,"Instances",obj_s_player);	
		}
		if ( global.game_type == "platformer" ){
			var new_player = instance_create_layer(_x,_y,"Instances",obj_p_player);	
		}
		//Assign which player this is new object represents.
		//Player 0, 1, 2, or 3 based on the length of the global.p_pad array
		new_player.p_number = array_length_1d(global.p_pad) -1 ;
		//Assign player object appropriate stats
		//Will probably want to create a separate script to handle this as it could get huge
		if ( new_player.p_number == 0 ){
			new_player.max_hp = global.p1.max_hp;
			new_player.hp = new_player.max_hp;
		}
		if ( new_player.p_number == 1 ){
			new_player.max_hp = global.p2.max_hp;
			new_player.hp = new_player.max_hp;
		}
		if ( new_player.p_number == 2 ){
			new_player.max_hp = global.p3.max_hp;
			new_player.hp = new_player.max_hp;
		}
		if ( new_player.p_number == 3 ){
			new_player.max_hp = global.p4.max_hp;
			new_player.hp = new_player.max_hp;
		}	
	}
}