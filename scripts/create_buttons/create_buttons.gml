/// @function						create_buttons(_image, _x, _y, _array_x, _array_y, _button_text, _selected, _mouse_type, _trigger_script)
/// @description					Setup the button's configuration and position in the selection array global.buttons 
///	@param {index} _image			Image you wish use for the button
///	@param {real} _x				Where to draw the button on the screen
///	@param {real} _y				Where to draw the button on the screen
///	@param {real} _array_x			Where in the buttons array to put this button ( used to determine which button you have selected and how navigation works )
///	@param {real} _array_y			Where in the buttons array to put this button ( used to determine which button you have selected and how navigation works )
///	@param {string} _button_text	Text to draw ontop of button
///	@param {boolean} _selected		If the button is the current selected button
///	@param {boolean} _mouse_type	Does the button react to mouse input
///	@param {script} _trigger_script	Script to trigger on button trigger

function create_buttons(_image, _x, _y, _array_x, _array_y, _button_text, _selected, _mouse_type, _trigger_script) {



	//Create and configure the button
	var _button = instance_create_layer(_x,_y,"Instances",obj_button);
	_button.button_text = _button_text;
	_button.selected = _selected;
	_button.image_index = _image;
	_button.mouse_type = _mouse_type;
	_button.trigger_script = _trigger_script; 

	//Make sure the menu button selection is on the selected button so navigation doesn't
	//get all "wonky".
	if ( _button.selected ){
		global.button_x = _array_x;
		global.button_y = _array_y;
	}

	//Add button to the button array for selection if this is not a mouse controlled button.
	//This array is used solely to navitage buttons with keyboard / controller inputs
	if ( !_mouse_type ){
		global.buttons[_array_y,_array_x] = _button.id; 
	}

	return _button.id;


}
