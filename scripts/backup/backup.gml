
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collide_slopes_backup(_xspeed,_height,_target){
	var _collide = true;
	//Test one space forward per xspeed 
	for ( var _x = 0; _x <= ceil(abs(_xspeed)); _x += 1 ){
		//Start with the assumption we will have a collision
		_collide = true;
		//Test once space forward per xspeed and up per pixel  
		for ( var _y = 0; _y <= _height; _y += 1 ){
			if ( !place_meeting(x+sign(_xspeed),y-_y,_target) ){
				x += sign(_xspeed);
				y -= _y;
				_collide = false;
				_x += _y;
				break;
			}
		}
		if ( _collide ){
			break;
		}
	}
	return _collide;
}