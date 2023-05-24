
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collideWall(_xspeed,_yspeed,_slope_y,_solid_target,_jump_through_target=-1 ){
	var _collisions = {
		collision		 : false, //Was there a collision at all?
		col_right		 : false, //Collision to the right detected
		col_left		 : false,  // Collision to the left detected
		col_top			 : false,   // Collision above detected
		col_bottom		 : false,// Collision below detected	
		col_vblock		 : -1,   // Id of the block collided vertically
		col_hblock		 : -1,    // Id of the block collided horizontally
	}
	
	/////////////////////////
	//Jump through / moving blocks
	if ( _jump_through_target ){
		var _col = instance_place(x+_xspeed,y+_yspeed+4,_jump_through_target)
		if ( _col && alarm[5] <= 0 ){
			//Check for a small 4 pixels down from the top of the platform &&  Make sure the object is down or relative to the platform.
			if ( bbox_bottom <= _col.bbox_top  + 4 && _yspeed >= _col.yspeed ){
				_collisions.col_bottom = true;
				_collisions.collision = true;
				_collisions.col_vblock = _col;
	
				//Make sure we are not colliding when setting 
				var _top_y = _col.bbox_top - ( bbox_bottom - y ) -1;
				//Moving platform collision check
				if ( ! place_meeting(x, _top_y, _solid_target ) ){
					y = _top_y;// + _col_jump_through.vspeed;
					_yspeed = 0;
					while ( instance_place(x,y, _solid_target) ){
						if global.debug then show_debug_message("Stuck moving platform!");
						y += 1;	
					}
				}	
			}
		}	
	}
	

	/////////////////////////
	//Solid  blocks	
	////
	
	//Vertical collision
	if ( place_meeting(x,y+_yspeed,_solid_target) ){
		for ( var _y = 0;_y<=abs(ceil(_yspeed)); _y+=1 ){
			var _col = instance_place(x , y + sign(_yspeed), _solid_target);
			if (! _col ) {
				y += sign(_yspeed);
			}
			else {
				// There was a collision
		        _collisions.collision = true;  
				// Move the maximum amount before a collision occurs
				// Get the id of the block collided with
				_collisions.col_vblock = _col;
				//Set collision direction based on movement direction
				if ( _col ){
					if ( _yspeed >= 0 ){
						_collisions.col_bottom = true;	
						//If stuck in floor get UNSTUCK in floor :)
						while ( instance_place(x,y, _solid_target) ){
							if global.debug then show_debug_message("Stuck down!");
							y -= 1;	
						}
					}
					else {
						_collisions.col_top = true;
						while ( instance_place(x,y, _solid_target) ){
							//If stuck in ceiling get UNSTUCK from ceiling :)
							if global.debug then show_debug_message("Stuck up!");
							y += 1;	
						}
					}
				}	
				break;	
			}
		}	

	}
	else {
		y += _yspeed;	
	}

	////
	//Check for slopes - must come before the horizontal check
	//Move Up Slope
	if ( place_meeting(x + _xspeed,y+ _yspeed,_solid_target) && _yspeed >= 0 ){
		//Test "_slope_y" many pixels up before calling it a collision
		for ( var _y = 0; _y <= _slope_y; _y += 1 ){
			if ( ! place_meeting(x+_xspeed,y -_y,_solid_target) ){
				y -= _y;
				_collisions.col_bottom = true;
				break;
			}
		}
	}	

	////
	//Horizontal collision and movement
	if ( place_meeting(x+_xspeed,y,_solid_target) ){
		for ( var _x = 0;_x<=abs(ceil(_xspeed));_x+=1 ){
			var _col = instance_place(x+sign(_xspeed), y, _solid_target);
			if ( ! _col ){
				x += sign(_xspeed);	
			}
			else {
				// There was a collision
			    _collisions.collision = true;
				// Move the maximum amount before a collision occurs
				// Get the id of the block collided with
				_collisions.col_hblock = _col;
				//Set collision direction based on movement direction
				if ( _xspeed > 0 ){
					_collisions.col_right = true;
					while ( instance_place(x,y, _solid_target) ){
						//If stuck in ceiling get UNSTUCK from ceiling :)
						if global.debug then show_debug_message("Stuck right!");
						x -= 1;	
					}				
				}
				else if ( _xspeed < 0 ){
					_collisions.col_left = true;
					while ( instance_place(x,y, _solid_target) ){
						//If stuck in ceiling get UNSTUCK from ceiling :)
						if global.debug then show_debug_message("Stuck left!");
						x += 1;	
					}				
				}
				break;
			}	
		}
	}
	else {
		x += _xspeed;	
	}
	

				
		//Move Down slope
	if ( ! _collisions.col_bottom && _yspeed = 0 && ! place_meeting(x + _xspeed,y+ 1,_solid_target) && place_meeting(x + _xspeed,y + _slope_y,_solid_target)  ){
		//Test "_slope_y" many pixels up before calling it a collision
		for ( var _y = 0; _y <= _slope_y * 2; _y += 1 ){
			if ( ! place_meeting(x ,y + 1,_solid_target) ){
				y += 1;
				_collisions.col_bottom = true;
			}
			else {
				break;	
			}
		}
	}

	//After all collisions check to see if we are on the ground
	var _col = instance_place(x,y+1, _solid_target);
	if ( _col ){
		_collisions.col_bottom = true;
		_collisions.col_vblock = _col;
		_collisions.collision = true;
	}


    ////
	// Return the collisions object
	return _collisions;
}