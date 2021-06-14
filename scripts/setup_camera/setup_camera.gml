/// @function setup_camera(_view, _zoom, _view_w, _view_h, _camera_target, _camera_border_x, _camera_border_y )
/// @description	Configure the camera view size, zoom, border, and target.  Returns the id of the camera to allow further customization.
///	@param {int}	_view				The camera view we are manipulating
///	@param {real}	_zoom				Zoom level of the camera
///	@param {real}	_view_w				The width of the camera view
///	@param {real}	_view_h				The height of the camera view
///	@param {index}	_camera_target		The object the camera should follow	
///	@param {real}	_camera_border_x	The horizontal border size before the camera starts following the _camera_target
///	@param {real}	_camera_border_y	The vertical border size before the camera starts following the _camera_target	

function setup_camera(_view, _zoom, _view_w, _view_h, _camera_target, _camera_border_x, _camera_border_y ) {

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

	//Set the application surfact to the appropriate size
	surface_resize(application_surface, view_wport[0], view_hport[0]);

	return _camera;
}
