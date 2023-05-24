/// @description Take control input and operate buttons
// You can write your code in this editor
operateButtons();

//Bouncing title
if ( alarm[0] ) { 
	image_xscale += 0.001;	
}
if ( alarm[1] ) { 
	image_xscale -= 0.001;	
}
if ( image_xscale > 1.01 ){
	image_xscale = 1.01;
}	
if ( image_xscale < 0.99 ){
	image_xscale = 0.99;
}	
image_yscale = image_xscale;