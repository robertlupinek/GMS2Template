/// @function assignInput( _max_players ) 
/// @desc Check to see if a player has joined and been assign a gamepad
///	@param {_max_players} _max_players	How many players and controllers does this game support
function assignInput( _max_players ) {
	//Loop through the gamepads and keyboard ( index 9 is keyboard ;) )

	var _input_assigned = false;  //Used to flag a gamepad / keyboard if it has been assigned
	var _input_new = false; //Used to flag if a new gamepad / keyboard was indeed assigned

	for ( var c = 0; c < 9; c +=1; ){
		//Check if button 1 or buttone 2 is pressed or not and if it is see if the input device
		//can be assigned to a player.
		if ( global.pad_b1_pressed[c] || global.pad_b2_pressed[c] )
		{
			//If you haven't assigned input devices to all 4 players
			if ( array_length_1d(global.p_pad) < _max_players ){
				_input_assigned = false;
				//Check if the input device has been assigned to a player ( check the gobal.p_pad array )
				for ( var p_used = 0;p_used < array_length_1d(global.p_pad); p_used += 1; ){
					if ( global.p_pad[p_used] == c  ){
						_input_assigned = true;
					}
				}
				//If the gamepad has not been assigned then assign that game pad to the next avaiable player
				if ( !_input_assigned ){
					//Append the current gamepad / controller / keyboard index to the player pad ( p_pad ) array.
					global.p_pad[array_length_1d(global.p_pad) ] = c;
					_input_new = true;
					//Important to break the for loop so that we return "true" when a new input is assigned 
					//If you don't it is possible to assign the input without taking any further action external to this script
					//such as creating the play object or what ever results from this script.
					break;
				}
			}
		}
	}

	return _input_new;

}


/// @description setup capture for ANY keyboard input
function inputControls() {

	//Reset all any input key variables
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


	//Check controller and keyboard state for player input
	for ( var _c = 0; _c < 9; _c +=1;){ 
	
		//Reset the just pressed variables
		global.pad_down_pressed[_c] = false;
		global.pad_up_pressed[_c] = false;
		global.pad_left_pressed[_c] = false;
		global.pad_right_pressed[_c] = false;
		global.pad_b1_pressed[_c] = false;
		global.pad_b2_pressed[_c] = false;
		global.pad_b3_pressed[_c] = false;
		global.pad_b4_pressed[_c] = false;
		global.pad_b5_pressed[_c] = false;
		global.pad_b6_pressed[_c] = false;
		global.pad_start_pressed[_c] = false;
		
		global.pad_d_down_pressed[_c] = false;
		global.pad_d_up_pressed[_c] = false;
		global.pad_d_left_pressed[_c] = false;
		global.pad_d_right_pressed[_c] = false;		
	
		//Note: There are only 8 possible gamepads.  Indice 8 or controller 9 is used represent the keyboard.
	
		//Up
		if ( ( keyboard_check(vk_up) && _c == 8 ) || gamepad_hat_value(_c, 0) == 9 || gamepad_hat_value(_c, 0) == 1 || gamepad_hat_value(_c, 0) == 3 || gamepad_axis_value(_c, gp_axislv) < 0 || gamepad_axis_value(_c, 5) < 0 ){
			if ( !global.pad_up[_c] ){ 
				global.pad_up_pressed[_c] = true;
				global.any_up_pressed = true;
			}
			global.pad_up[_c] = true;	
			global.any_up[_c] = true;	
		}
		else {
			global.pad_up[_c] = false;	
		}
		//Right
		if ( ( keyboard_check(vk_right) && _c == 8 ) || gamepad_hat_value(_c, 0) == 3 || gamepad_hat_value(_c, 0) == 2 || gamepad_hat_value(_c, 0) == 6 || gamepad_axis_value(_c, gp_axislh) > 0 || gamepad_axis_value(_c, 4) > 0 ){
			if ( !global.pad_right[_c] ){
				global.pad_right_pressed[_c] = true;
				global.any_right_pressed = true;
			}	
			global.pad_right[_c] = true;	
			global.any_right = true;
		}
		else {
			global.pad_right[_c] = false;	
		}
		//Down
		if ( ( keyboard_check(vk_down)  && _c == 8 ) || gamepad_hat_value(_c, 0) == 12 || gamepad_hat_value(_c, 0) == 4 || gamepad_hat_value(_c, 0) == 6 || gamepad_axis_value(_c, gp_axislv) > 0 || gamepad_axis_value(_c, 5) > 0 ){
			if ( !global.pad_down[_c] ){
				global.pad_down_pressed[_c] = true;
				global.any_down_pressed = true;
			}
			global.pad_down[_c] = true;	
			global.any_down = true;
		}
		else {
			global.pad_down[_c] = false;	
		}
		//Left
		if ( ( keyboard_check(vk_left) && _c == 8 ) || gamepad_hat_value(_c, 0) == 9 || gamepad_hat_value(_c, 0) == 8 || gamepad_hat_value(_c, 0) == 12 || gamepad_axis_value(_c, gp_axislh) < 0 || gamepad_axis_value(_c, 4) < 0  ){
			if ( !global.pad_left[_c] ){
				global.pad_left_pressed[_c] = true;
				global.any_left_pressed = true;
			}	
			global.pad_left[_c] = true;
			global.any_left = true;
		}
		else {
			global.pad_left[_c] = false;	
		}
		//Button 1
		if ( ( keyboard_check(ord("Z") ) && _c == 8 ) || gamepad_button_value(_c,gp_face1) ){
			if ( !global.pad_b1[_c] ){
				global.pad_b1_pressed[_c] = true;
				global.any_b1_pressed = true;
			}	
			global.pad_b1[_c] = true;	
			global.any_b1 = true;
		}
		else {
			global.pad_b1[_c] = false;	
		}
		//Button 2
		if ( ( keyboard_check(ord("X") ) && _c == 8 ) || gamepad_button_value(_c,gp_face2) ){
			if ( !global.pad_b2[_c] ){
				global.pad_b2_pressed[_c] = true;
				global.any_b2_pressed = true;
			}		
			global.pad_b2[_c] = true;	
			global.any_b2 = true;
		}
		else {
			global.pad_b2[_c] = false;	
		}
		//Button 3
		if ( ( keyboard_check(ord("C") ) && _c == 8 ) || gamepad_button_value(_c,gp_face3) ){
			if ( !global.pad_b3[_c] ){
				global.pad_b3_pressed[_c] = true;
				global.any_b3_pressed = true;
			}		
			global.pad_b3[_c] = true;	
			global.any_b3 = true;	
		}
		else {
			global.pad_b3[_c] = false;	
		}
		//Button 4
		if ( ( keyboard_check(ord("V") ) && _c == 8 ) || gamepad_button_value(_c,gp_face4) ){
			if ( !global.pad_b4[_c] ){
				global.pad_b4_pressed[_c] = true;
				global.any_b4_pressed = true;
			}		
			global.pad_b4[_c] = true;	
			global.any_b4 = true;	
		}
		else {
			global.pad_b4[_c] = false;	
		}
		//Button 5
		if ( ( keyboard_check(ord("Q") ) && _c == 8 ) || gamepad_button_value(_c, gp_shoulderl) || gamepad_button_value(_c, gp_shoulderlb) ){
			if ( !global.pad_b5[_c] ){
				global.pad_b5_pressed[_c] = true;
				global.any_b5_pressed = true;
			}		
			global.pad_b5[_c] = true;	
			global.any_b5 = true;	
		}
		else {
			global.pad_b5[_c]= false;	
		}
		//Button 6
		if ( ( keyboard_check(ord("E") ) && _c == 8 ) || gamepad_button_value(_c, gp_shoulderr) || gamepad_button_value(_c, gp_shoulderrb) ){
			if ( !global.pad_b6[_c] ){
				global.pad_b6_pressed[_c] = true;
				global.any_b6_pressed = true;
			}	
			global.pad_b6[_c] = true;	
			global.any_b6 = true;
		}
		else {
			global.pad_b6[_c] = false;	
		}
		//Button Start Button
		if ( ( ( keyboard_check(vk_enter ) || keyboard_check(vk_escape ) )  && _c == 8 )  || gamepad_button_value(_c, gp_start) || gamepad_button_value(_c, gp_select)) {
			if ( !global.pad_start[_c] ){
				global.pad_start_pressed[_c] = true;
				global.any_start_pressed = true;
			}	
			global.pad_start[_c] = true;
			global.any_start = true;
		}
		else {
			global.pad_start[_c] = false;	
		}
		
		//Button DPAD Up
		if ( gamepad_button_value(_c, gp_padu)) {
			if ( !global.pad_d_up[_c] ){
				global.pad_d_up_pressed[_c]  = true;
				global.any_d_up_pressed = true;
			}	
			global.pad_d_up[_c] = true;
			global.any_d_up = true;
		}
		else {
			global.pad_d_up[_c] = false;	
		}		

		//Button DPAD Right
		if ( gamepad_button_value(_c, gp_padr)) {
			if ( !global.pad_d_right[_c] ){
				global.pad_d_right_pressed[_c]  = true;
				global.any_d_right_pressed = true;
			}	
			global.pad_d_right[_c] = true;
			global.any_d_right = true;
		}
		else {
			global.pad_d_right[_c] = false;	
		}	
		
		//Button DPAD Down
		if ( gamepad_button_value(_c, gp_padd)) {
			if ( !global.pad_d_down[_c] ){
				global.pad_d_down_pressed[_c]  = true;
				global.any_d_down_pressed = true;
			}	
			global.pad_d_down[_c] = true;
			global.any_d_down = true;
		}
		else {
			global.pad_d_down[_c] = false;	
		}	
		
		//Button DPAD Left
		if ( gamepad_button_value(_c, gp_padl)) {
			if ( !global.pad_d_left[_c] ){
				global.pad_d_left_pressed[_c]  = true;
				global.any_d_left_pressed = true;
			}	
			global.pad_d_left[_c] = true;
			global.any_d_left = true;
		}
		else {
			global.pad_d_left[_c] = false;	
		}			
	
	}

}
