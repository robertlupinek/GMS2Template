/// @description Function for button when triggered

function trigger_button_next() {
	var transition = instance_create_depth(x,y,-100000, obj_room_transition);
	transition.alarm[0] = 60;
	transition.image_alpha = 0;
}
