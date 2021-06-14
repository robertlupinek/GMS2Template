/// @description Function for button when triggered

function trigger_button_resume() {
	//Trigger the unpause actions for hte pause controller 
	with(obj_pause_controller){
		unpause = true;	
	}
}
