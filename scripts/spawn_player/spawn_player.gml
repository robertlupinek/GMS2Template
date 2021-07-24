/// @function	spawn_player(_x,_y
/// @desc		Spawn player at coordinates, assign controls, andset default stats. 
///	@param		{_x} _x	X Coordinate to spawn player
///	@param		{_y} _y	Y Coordinate to spawn player
function spawn_player(_x,_y){

	//Triggers if a new input devices "activation" button was pressed
	if ( assign_input(global.max_players) ){
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