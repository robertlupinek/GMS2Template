/// @description Move player on collision

//Much safer moving this in line with the rest of the collision routine stuff but...

var _col = instance_place(x,y-2,obj_moveable);
if ( _col ){

	_col._tmp_move_speed = jump_speed;
	with ( _col ){
		if ( ! place_meeting(x,y-_tmp_move_speed-2,obj_block) ){
			//We were getting the occasionl stuck in floor which is freaking odd...
			//...I think it is a matter of setting yspeed with no collision.
			//...also probably the timing of this objects step event.
			//AH problably gets stuck in the floor sometimes and vspeed is negative triggering 
			//stuck in floor pushing down!  DERP!!!!  Yup, that was it!
			//Now why are my collisions constantly sticking in the floor..
			_col.y -= 1; 
			_col.yspeed -= _tmp_move_speed;
			_col.jump_count -= 1;
		}
	}
	yscale = 0.2;
}

if yscale > 0 then yscale -= 0.01;
