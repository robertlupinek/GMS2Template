// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createEventButton(){
/// @description Button object used for creating in game and menu buttons.
// This object COULD potentially be used as a basis for an inventory

	button_text = "New Game";  //Text to display on the button
	xscale = 1; //Button image x scale
	yscale = 1; //Button image y scale
	angle = 0;  //Button image angle
	selected = false;  //Is the button currently selected?
	just_selected = false;	//Was the button JUST selected - triggers only once when a button is selected
	mouse_type = false; //Is this button operated using mouse?
	trigger_script = -1;  //What script should trigger if this button is used?


	///"Special" Effects

	//Init the outline shader
	outlineShaderInit();
	
	// Initialize alarms
	initAlarms();
}

function stepEventButton(){
/// @description Handle some effects when selected
	if ( selected ){
		//Trigger things that should happen only when button is JUST selected
		if ( !just_selected ){
			//Balloon button out when first selected
			setAlarm("just_selected",20);
		}
		just_selected = true;		
	}
	else {
		just_selected = false;	
	}
	
	// Set the pulsing animation alarm over and over to be used if selected
	if getAlarm("pulse") <= 0 then setAlarm("pulse",60);
	stepAlarm();
}

function drawEventButton(){
/// @description Draw button, text and effects
// 
	draw_set_alpha(1);
	draw_set_color(c_white);

	var xoffset = 0;
	if ( selected ){
		if ( getAlarm("pulse") < 30 ){
			outlineShaderStart(getAlarm("pulse")*.1,c_white);
		} 
		else {
			outlineShaderStart(3 - getAlarm("pulse")*.1,c_white);	
		}
		xoffset = -5;
	}
	else {
		xoffset = 0;
	}

	//Balloon button out if just selected
	if ( getAlarm("just_selected") < 10 && getAlarm("just_selected") > 0 ){
		image_xscale -= 0.02;
	} 
	else if ( getAlarm("just_selected") >= 10 ){
		image_xscale += 0.01;
	}
	else {
		image_xscale = 1;	
	}

	image_yscale = image_xscale;

	draw_sprite_ext(sprite_index,-1,x + xoffset,y,image_xscale,image_yscale,image_angle,c_white,1);
	
	if ( selected ){
		outlineShaderEnd();
	}		
	
	draw_set_font(global.font_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_transformed(x + xoffset ,y, button_text,xscale,yscale,angle );
}