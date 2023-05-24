/// @function				centerCamera(_object, _camera)
/// @description			Get and return the center point between two points
///	@param {index} _object	The objects to use to find the center of
///	@param {index} _camera	The camera object we are centering
function centerCamera(_object, _camera) {

///	@param {index} _object	The objects to use to find the center of. i.e. use obj_player to find the center of all player objects
///	@param {index} _camera	The camera object we are centering

	var _target = _object;
	var _target2 = _object;
	var _target_count = instance_number(_target);

	var _last_xd = 0;
	var _last_yd = 0;

	var _left = 0;
	var _right = 0;
	var _top = 0;
	var _bottom = 0;	

	//Position camera
	if ( instance_exists(_object) ) {
	
		//Loop through all targets 
		if ( _target_count > 1 ){
		
			//Describe the rectangle to find the center of by comparing all target objects
			//finding the greatest distances between them
			for (var i = 0; i < instance_number(_object); ++i;){
				_target = instance_find(_object,i);

				for (var ii = 0; ii < instance_number(_object); ++ii;){
					_target2 = instance_find(_object,ii);
				    //Get distances to objects
					var _xd = abs(_target.x - _target2.x);
					var _yd = abs(_target.y - _target2.y);		
					//If the distances are greater use those values to describe the rectangle
					if ( _xd > _last_xd ){
						if ( _target.x > _target2.x ){
							_right = _target.x;
							_left = _target2.x;
						}
						else {
							_right = _target2.x;
							_left = _target.x;
						}
						_last_xd = _xd;
					}
					//If the distances are greater use those values to describe the rectangle
					if ( _yd > _last_yd ){
						if ( _target.y > _target2.y ){
							_top = _target2.y;
							_bottom = _target.y;
						}
						else {
							_top = _target.y;
							_bottom = _target2.y;
						}
						_last_yd = _yd;
					}				
				}			
			}
		
			//Now that we have calculated the rectangle let's find it's center
			_camera.x = round( (_left + _right) / 2 );
			_camera.y = round( (_top + _bottom) / 2 );
		
		}
		else {
			_camera.x = target.x;
			_camera.y = target.y;
		}
	}
	//Only for debugging purposes you can run this in the draw event to see the rectangle 
	//draw_rectangle(_left,_top,_right,_bottom,true);
}

/// @function setupCamera(_view, _zoom, _view_w, _view_h, _camera_target, _camera_border_x, _camera_border_y )
/// @description	Configure the camera view size, zoom, border, and target.  Returns the id of the camera to allow further customization.
///	@param {int}	_view				The camera view we are manipulating
///	@param {real}	_zoom				Zoom level of the camera
///	@param {real}	_view_w				The width of the camera view
///	@param {real}	_view_h				The height of the camera view
///	@param {index}	_camera_target		The object the camera should follow	
///	@param {real}	_camera_border_x	The horizontal border size before the camera starts following the _camera_target
///	@param {real}	_camera_border_y	The vertical border size before the camera starts following the _camera_target	

function setupCamera(_view, _zoom, _view_w, _view_h, _camera_target, _camera_border_x, _camera_border_y ) {

	var _camera = view_camera[_view ];

	//Enable the view
	view_enabled = true;
	view_visible[_view] = true;

	//Set the view width and height
	view_wport[_view] = _view_w;
	view_hport[_view] = _view_h;
	window_set_size(_view_w,_view_h);

	//Setup the active camera
	camera_set_view_target(_camera,_camera_target);
	camera_set_view_border(_camera, _camera_border_x, _camera_border_y)
	camera_set_view_size(_camera,_view_w/_zoom,_view_h/_zoom);

	//Set the application surface to the desired size
	surface_resize(application_surface, view_wport[0], view_hport[0]);

	return _camera;
}

/// @function					checkOutsideView(_x, _y,_x2, _y2, _view, _check_l, _check_t, _check_r, _check_b )
/// @description				Checks to see if described rectangle is outside of the requested camera view and returns boolean
/// example:
/// Check view 0 boundaries left, right, NOT top, bottom 
/// checkOutsideView(bbox_left,bbox_right,bbox_top,bbox_bottom,0,true,true,false,true);
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

function checkOutsideView(_x, _y,_x2, _y2, _view, _check_l, _check_t, _check_r, _check_b ) {

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
