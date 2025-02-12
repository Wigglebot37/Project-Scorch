/// @desc Sets View Size
// Sets size of view
camera_set_view_size(view,view_w,view_h);

// Sets position of view
if(instance_exists(o_player)) {
	// Centers on object coordinates, makes sure camera doesn't go outside room
	var test_x=clamp(o_player.x-view_w/2,0,room_width-view_w);
	var test_y=clamp(o_player.y-view_h/2,0,room_height-view_h);
	
	// Retrieves current view coordinates
	var cur_x=camera_get_view_x(view);
	var cur_y=camera_get_view_y(view);
	// Sets a speed to lerp at
	var xspd=0.1,yspd=0.1;
	if(abs(cur_x-test_x)<0.5) xspd=0.5;
	if(abs(cur_y-test_y)<0.5) yspd=0.5;
	// Snaps camera to position if within a small difference
	if(abs(cur_x-test_x)<0.01) cur_x=test_x;
	if(abs(cur_y-test_y)<0.01) cur_y=test_y;
	
	// Sets the camera view position to scale towards object position
	var _xx=lerp(cur_x,test_x,xspd);
	var _yy=lerp(cur_y,test_y,yspd);
	// Changes values that cause large noticable offsets
	switch(round(_xx*100)) { 
		case 10:
		case 30:
		case 50:
		case 70:
		case 90: _xx+=0.05; break;
	}
	switch(round(_yy*100)) {
		case 10:
		case 30:
		case 50:
		case 70:
		case 90: _yy+=0.05; break;
	}
	
	//display_mouse_set(display_mouse_get_x()+((test_x-cur_x)/window_scale),display_mouse_get_y()+(test_y-cur_y)/window_scale);
	if(keyboard_check_pressed(vk_f3)) {
		manual=!manual;
		if(manual) {
			vx2=round(_xx);
			vy2=round(_yy);
		}
	}
	if(!manual) camera_set_view_pos(view,_xx,_yy);
	else {
		vy2 += (keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up))*0.01;
		vx2 += (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))*0.01;
	
		vy2 += (keyboard_check(ord("K"))-keyboard_check(ord("I")))*2;
		vx2 += (keyboard_check(ord("L"))-keyboard_check(ord("J")))*2;
		camera_set_view_pos(view,vx2,vy2);
	}
}