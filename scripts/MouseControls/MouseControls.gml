/// @function checkMouseOver(_target)
/// @description	Check if mouse x and y are over the bounding box of the _target object.
///	@param {index}	_target	The object we are checking to see if we are "mousing over"
function checkMouseOver(_target) {

	_return = 0;
	if ( mouse_x  > _target.bbox_left && mouse_x < _target.bbox_right )
	{
	    if ( mouse_y  > _target.bbox_top && mouse_y < _target.bbox_bottom )
	    {
	        _return = 1;
	    }
	}

	return _return;



}
