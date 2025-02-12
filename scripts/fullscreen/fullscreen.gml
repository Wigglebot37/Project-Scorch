/// @function		fullscreen();
/// @description	Turns fullscreen on or off.

function fullscreen() {
	// Turns fullscreen on or off
	var win=window_get_fullscreen();
	window_set_fullscreen(!win);
	var winsc=o_camera.window_scale;
	// Fullscreened
	if(!win) {
		// Making application surface size of display
		surface_resize(application_surface,res_w,res_h);
		// Adjusts window and view sizes accordingly
		win_w+=res_w-ideal_w;
		win_h+=res_h-ideal_h;
		view_w+=(res_w-ideal_w)/winsc;
		view_h+=(res_h-ideal_h)/winsc;
		display_set_gui_size(res_w,res_h);
	// Windowed
	} else {
		// Making application surface size of original scaled window
		surface_resize(application_surface,ideal_w,ideal_h);
		// Adjusts window and view sizes accordingly
		win_w-=res_w-ideal_w;
		win_h-=res_h-ideal_h;
		view_w-=(res_w-ideal_w)/winsc;
		view_h-=(res_h-ideal_h)/winsc;
		display_set_gui_size(ideal_w,ideal_h);
	}
}