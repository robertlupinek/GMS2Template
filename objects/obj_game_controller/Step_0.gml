/// @description The game controller's step event controls input and game event status checks and settings.
//


spawn_player(90,100);

//Set camera target 
with(obj_camera){
	target = obj_player;	
}


	
if ( game_start == 1 ){
	
	//End game if there are no more player objects and game_start = 1;
	//Can go to Game Over screen or what ever you choose
	if ( instance_number(obj_player) <= 0 ){
		room_goto(rm_main_menu);
	}
} 
else {
	//Start the game if a player has entered the game
	if ( instance_number(obj_player) >= 1 ){
		game_start = 1;
	}	
}


//Level complete!
if ( ( !instance_number(obj_enemy) && global.game_type == "shooter"  ) || keyboard_check_pressed(ord("N") )){
	trigger_button_next();
}
