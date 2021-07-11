/// @function read_save_game(_save_filename )
/// @desc Read save game data from file
///	@param {filename} _save_filename	The filename of the save file ( allows for multiple saves ) 
///	@param {ds_map}	_save_data_map		The ds_map that stores the save data

function read_save_game(_save_filename ) {

	if ( file_exists( _save_filename ) ){
		//Load file to buffer then string
		var _buffer = buffer_load(_save_filename );
		var _buffer_string = buffer_read(_buffer,buffer_string);
		//Create temporary ds_map from JSON object loaded from file.
		var _json_struct = json_parse(_buffer_string);
		// Copy map with correct key from loaded JSON object to correct ds_map.
		global.p1 = _json_struct.p1
		global.p2 = _json_struct.p2
		global.p3 = _json_struct.p3
		global.p4 = _json_struct.p4
		global.game_state.save_room = _json_struct.save_room
	
		show_debug_message("Game Loaded!");
		show_debug_message(global.p1.max_hp);
		show_debug_message(global.p2.max_hp);
		show_debug_message(global.p3.max_hp);
		show_debug_message(global.p4.max_hp);			
		return true;
	}
	else
	{
		show_debug_message("No Save File To Load!")	
		return false;
	}




}
