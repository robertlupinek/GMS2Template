/// @description Function that is used to control the state of the buttons.  This will need to be run in the step event of any object that is used to create the butttons.

/// @function						createButtons(_image, _x, _y, _array_x, _array_y, _button_text, _selected, _mouse_type, _trigger_script)
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
function createButtons(_image, _x, _y, _array_x, _array_y, _button_text, _selected, _mouse_type, _trigger_script) {

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

/// @description Clear button array and any other actions to reset buttons
function clearButtons() {

	global.buttons = 0;
	global.button_x = 0;
	global.button_y = 0;

}

function operateButtons() {

	//Loop through buttons
	//We use this for mouse selection and anything else we would want to trigger
	with(obj_button){
		///Mouse handling
		// If a mouse type button first deselect it then select it IF the mouse is over it.
		if ( mouse_type ){
			selected = false;	
			if ( checkMouseOver(id) ){
					selected = true;	
			}
		}
	}

	///Keyboard and controller selection handling
	//Move down through the menu
	if ( global.any_down_pressed ){
		global.button_y += 1;
		if ( global.button_y > ( array_height_2d(global.buttons) -1 ) ){
			global.button_y = 0;	
		}
		//Set button x to the highest button x if it is higher than max
		if ( global.button_x > ( array_length_2d(global.buttons,global.button_y) -1 ) ){
			global.button_x = array_length_2d(global.buttons,global.button_y) -1;
		}
		//Deselect all buttons
		with( obj_button ){
			if ( !mouse_type ){
				selected = false;
			}
		}
		//Set selected button to selected
		with(global.buttons[global.button_y,global.button_x]){
			if ( !mouse_type ){
				selected = true;
			}
		}
	}

	//Move up through the menu
	if ( global.any_up_pressed ){
		global.button_y -= 1;
		if ( global.button_y < 0 ){
			global.button_y = array_height_2d(global.buttons) -1;	
		}
		//Set button x to the highest button x if it is higher than max
		if ( global.button_x > ( array_length_2d(global.buttons,global.button_y) -1 ) ){
			global.button_x = array_length_2d(global.buttons,global.button_y) -1;
		}	
		//Deselect all buttons
		with( obj_button ){
			if ( !mouse_type ){
				selected = false;
			}
		}
		//Set selected button to selected
		with(global.buttons[global.button_y,global.button_x]){
			if ( !mouse_type ){
				selected = true;
			}
		}
	}

	// Move right through the menu
	if ( global.any_right_pressed ){
		global.button_x += 1;
		if ( global.button_x > ( array_length_2d(global.buttons,global.button_y) -1 ) ){
			global.button_x = 0;	
		}
		//Deselect all buttons
		with( obj_button ){
			if ( !mouse_type ){
				selected = false;
			}
		}
		//Set selected button to selected
		with(global.buttons[global.button_y,global.button_x]){
			if ( !mouse_type ){
				selected = true;
			}
		}
	}

	//Move up through the menu
	if ( global.any_left_pressed ){
		global.button_x -= 1;
		if ( global.button_x < 0 ){
			global.button_x = array_length_2d(global.buttons,global.button_y) -1;	
		}
		//Deselect all buttons
		with( obj_button ){
			if ( !mouse_type ){
				selected = false;
			}
		}
		//Set selected button to selected
		with(global.buttons[global.button_y,global.button_x]){
			if ( !mouse_type ){
				selected = true;
			}
		}
	}

	///Trigger the script if appropriate keyboard/mouse/controller button is pressed
	//Controller / Keyboard controlled buttons
	if ( global.any_b1_pressed  ) {
		with(obj_button){
			if ( selected && !mouse_type ){
				script_execute(trigger_script)
			}
		}
	}
	//Mouse controlled buttons
	if ( mouse_check_button_pressed(mb_left) ) {
		with(obj_button){
			if ( selected && mouse_type ){
				script_execute(trigger_script)
			}
		}
	}

}




