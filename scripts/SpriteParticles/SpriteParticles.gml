/// @description The purpose of this script is to create little objects out of sprites, or little chunks of em for explosions and stuff.
///	@param {index}	_chunk_sprite	Sprite to slice and dice
///	@param {real}	_chunk_size		How big each chunk should be
///	@param {real}	_chunk_x_org		X Offset to start the slice process.  i.e. If sprite has a origin in the center set this value to a negative number that starts on the left of the sprite
///	@param {real}	_chunk_y_org		Y Offset to start the slice process.  i.e. If sprite has a origin in the center set this value to a negative number that starts on the top of the sprite
///	@param {real}	_chunk_type		Number representing the behavior of the object created.  Update doc when we create more then 1 behavior :)

function diceSprite(_chunk_sprite, _chunk_size, _chunk_x_org, _chunk_y_org, _chunk_type) {

	var _chunk_r = floor( sprite_get_height(_chunk_sprite) / _chunk_size );
	var _chunk_c = floor( sprite_get_width(_chunk_sprite) / _chunk_size );


	for ( rr = 0;rr < _chunk_r;rr+=1)
	{
	    for ( cc = 0;cc < _chunk_c;cc+=1)
	    {
	        chunk = instance_create_depth(_chunk_x_org + cc * _chunk_size,_chunk_y_org +rr * _chunk_size,0,obj_sprite_chunk )
	        chunk.sprite_index = _chunk_sprite;
        
        
	        chunk.l = cc * _chunk_size;
	        chunk.t = rr * _chunk_size;
        
	        chunk.w = _chunk_size;
	        chunk.h = _chunk_size;
    
			if ( _chunk_type == 0 ){
		        chunk.type = _chunk_type;        
		        chunk.speed = 2 + random(1);
		        chunk.direction = random(360);
			}
			if ( _chunk_type == 1 ){
		        chunk.type = _chunk_type;        
		        chunk.gravity = 0.1+random(0.2);
				chunk.image_angle = 358 + random(4);
				chunk.gravity_direction = 270;
			}			
	    } 
	}
 
}
