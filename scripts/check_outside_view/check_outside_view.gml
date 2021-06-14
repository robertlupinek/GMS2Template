/// @function					check_outside_view(_x, _y,_x2, _y2, _view, _check_l, _check_t, _check_r, _check_b )
/// @description				Checks to see if described rectangle is outside of the requested camera view and returns boolean
/// example:
/// Check view 0 boundaries left, right, NOT top, bottom 
/// check_outside_view(bbox_left,bbox_right,bbox_top,bbox_bottom,0,true,true,false,true);
///	@param {real}  _x			Left side of rectangle
///	@param {real} _y			Top side of rectangle to check
///	@param {real} _x2			Right side of rectangle
///	@param {real} _y2			Botton of rectangle
///	@param {real} _view			Camera view to check against
	

	//Provide which directions outside the view you want to check
///	@param {boolean} _check_l	Check against left border of view
///	@param {boolean} _check_t	Check against top border of view
///	@param {boolean} _check_r	Check against right border of view
///	@param {boolean} _check_b	Check against bottom border of view

function check_outside_view(_x, _y,_x2, _y2, _view, _check_l, _check_t, _check_r, _check_b ) {

	//Get the camera configuration
	var _camera = view_get_camera(_view);
	var _cx = camera_get_view_x(_camera);
	var _cy = camera_get_view_y(_camera);
	var _cw = camera_get_view_width(_camera);
	var _ch = camera_get_view_height(_camera);
	var _outside = false;

	//Check left
	if ( _x < _cx && _check_l ) {
		_outside = true;
	}

	//Check right
	if ( _x2 > _cx + _cw && _check_r ){
		_outside = true;
	}

	//Check top
	if ( _y < _cy && _check_t ) {
		_outside = true;
	}


	//Check bottom
	if ( _y2 > _cy + _ch && _check_b ){
		_outside = true;
	}

	return _outside;
}
