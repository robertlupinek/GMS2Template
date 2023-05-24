/// @description Create buttons and setup effects

//Reset button configuration before creating new buttons
clearButtons();

/// Create the buttons for the main menu

//Create buttons for Load Game default selected IF the save file exists

if ( room_get_name(room) == "rm_main_menu" ) {
	//Display Load Game and auto select IF the save game file exists
	if ( file_exists( global.save_file_name ) ){
		createButtons(spr_big_button,316,138,0,0,"Load Game",true,false,triggerButtonLoad);
		createButtons(spr_big_button,316,188,0,1,"New Game",false,false,triggerButtonNext);
		createButtons(spr_big_button,316,238,0,2,"Quit",false,false,triggerButtonQuit);
	}
	else {
		createButtons(spr_big_button,316,138,0,0,"New Game",true,false,triggerButtonNext);
		createButtons(spr_big_button,316,188,0,1,"Quit",false,false,triggerButtonQuit);
	}
}
else {
	//Display the button test screen
	createButtons(spr_big_button,160,138,0,0,"Next",true,false,triggerButtonNext);	
	createButtons(spr_big_button,304,138,1,0,"Back",false,false,triggerButtonBack);
	createButtons(spr_big_button,160,188,0,1,"Controls",false,false,triggerButtonControls);
	createButtons(spr_big_button,304,188,1,1,"test 4",false,false,triggerButtonDebug);		
	//Mouse controoled button
	createButtons(spr_big_button,160,238,0,0,"mouse 1",false,true,triggerButtonDebug);	
	createButtons(spr_big_button,304,238,0,0,"mouse 1",false,true,triggerButtonDebug);	
}

image_alpha = 0.5;
alarm[0] = 30;






















