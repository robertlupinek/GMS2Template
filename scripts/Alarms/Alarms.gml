
function initAlarms(){
	// Setup the alarms struct.
	// Should most likey be set in an objects create event
	my_alarms = {}	
}


function setAlarm(_alarm,_steps,_func=-1){
	//Set the alarm name, function to trigger and steps to wait for the trigger.
	// Can bet set anywhere including the function for the alarm
	my_alarms[$ _alarm] = {
		func : _func, // Function to trigger 
		steps : _steps // How many steps to wait to trigger
	}
}

function getAlarm(_alarm){
	// Default the step the alarm is on to 0 if no key is set in the my_alarms struct
	var _step = 0;
	// If the alarm exists in the my_alarms struct then return the value of steps
	if ( struct_exists(my_alarms,_alarm) ){
		_step = my_alarms[$ _alarm].steps
	}
	return _step;
}

function stepAlarm(){
	var _keys = variable_struct_get_names(my_alarms);
	// Loop through all of the my_alarms
	for (var i = array_length(_keys)-1; i >= 0; --i) {
	    // Set _k and _v to the key and value as you loop
		var _k = _keys[i];
	    var _v = my_alarms[$ _k];
		// If the remaining steps for the current alarm > 0 then reduce by one and trigger function if alarm.steps < 0
	    if ( my_alarms[$ _k].steps > 0 ){
			my_alarms[$ _k].steps -= 1;
			if ( my_alarms[$ _k].steps <= 0 ){
				// If a function was set for this alarm then trigger it please
				if ( my_alarms[$ _k].func ){
					my_alarms[$ _k].func();
				}
			}
		}
		else {
			my_alarms[$ _k].steps = 0;
		}
		
	}
}