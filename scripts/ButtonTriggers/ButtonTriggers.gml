
// Pause screen button triggers

function triggerButtonResume() {
	//Trigger the unpause actions for hte pause controller 
	with(obj_pause_controller){
		unpause = true;	
	}
}

function triggerButtonQuit() {
	game_end();
}


// Room movement triggers

function triggerButtonNext() {
	fadeMusic();
	var transition = instance_create_depth(x,y,-100000, obj_room_transition);
	transition.alarm[0] = 60;
	transition.image_alpha = 0;
}

function triggerButtonBack() {
	fadeMusic();
	var transition = instance_create_depth(x,y,-100000, obj_room_transition);
	transition.alarm[0] = 60;
	transition.image_alpha = 0;	
	room_goto_previous();
}

function triggerButtonControls() {
	var transition = instance_create_depth(x,y,-100000, obj_room_transition);
	transition.alarm[0] = 60;
	transition.image_alpha = 0;	
	room_goto(rm_controls_test);
}


// Save and load buttons

function triggerButtonLoad() {
	fadeMusic();
	//Clear out the gamepad settings.
	//This variable is what is used to assign a gamepad or keyboard to a player.
	//We are clearing it here because we want the player to pick their input device again.
	global.p_pad = [];
	//Read in the save game data
	readSaveGame(global.save_file_name );
	//Goto the room in the file
	room_goto( asset_get_index(global.game_state.save_room ) );
}

// Debug buttons 

function triggerButtonDebug() {
	show_debug_message("Triggered triggerButtonDebug script.");
}




