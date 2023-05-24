
// Define the function for the alarm to run on trigger.
_func = function(){
	repeat(1800){
		instance_create_layer(random(room_width),random(room_height),"Instances",obj_paricle_a);
	}
	instance_create_layer(0,0,"Instances",obj_alarm_test);
	instance_destroy();	
}

// Check to see if the alarm is <= 0 and if it is then set it.
// This will keep you alarm from reseting over and over again.
if getAlarm("my_alarm") <= 0 then setAlarm("my_alarm",60,_func);

// This function must be called in the step event to reduce the step counter and finally trigger the function.
stepAlarm();