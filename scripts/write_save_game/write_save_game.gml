/// @function							write_save_game(_save_filename, _save_data_map)
/// @desc								Write save game data to file
///	@param {filename} _save_filename	The filename of the save file ( allows for multiple saves ) 
///	@param {ds_map}	_save_data_map		The ds_map that stores the save data

function write_save_game(_save_filename, _save_data_map) {

	var _string = json_encode(_save_data_map);
	var _buffer = buffer_create( string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write( _buffer, buffer_string, _string );
	buffer_save( _buffer,_save_filename );
	buffer_delete( _buffer);

	show_debug_message("Game Saved!")

}
