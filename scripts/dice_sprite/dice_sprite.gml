/// @description The purpose of this script is to create little objects out of sprites, or little chunks of em for explosions and stuff.
///	@param {index}	chunk_sprite	Sprite to slice and dice
///	@param {real}	chunk_size		How big each chunk should be
///	@param {real}	chunk_x_org		X Offset to start the slice process.  i.e. If sprite has a origin in the center set this value to a negative number that starts on the left of the sprite
///	@param {real}	chunk_y_org		Y Offset to start the slice process.  i.e. If sprite has a origin in the center set this value to a negative number that starts on the top of the sprite
///	@param {real}	chunk_type		Number representing the behavior of the object created.  Update doc when we create more then 1 behavior :)

function dice_sprite(chunk_sprite, chunk_size, chunk_x_org, chunk_y_org, chunk_type) {

	var chunk_r = floor( sprite_get_height(chunk_sprite) / chunk_size );
	var chunk_c = floor( sprite_get_width(chunk_sprite) / chunk_size );


	for ( rr = 0;rr < chunk_r;rr+=1)
	{
	    for ( cc = 0;cc < chunk_c;cc+=1)
	    {
	        chunk = instance_create_depth(chunk_x_org + cc * chunk_size,chunk_y_org +rr * chunk_size,0,obj_sprite_chunk )
	        chunk.sprite_index = chunk_sprite;
        
        
	        chunk.l = cc * chunk_size;
	        chunk.t = rr * chunk_size;
        
	        chunk.w = chunk_size;
	        chunk.h = chunk_size;
    
	        chunk.type = chunk_type;        
	        chunk.speed = 2 + random(1);
	        chunk.direction = random(360);
	    } 
	}
 
}
