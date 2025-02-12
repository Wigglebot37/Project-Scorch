/// @desc Obtains vertices
if(mouse_check_button_pressed(mb_right)) {
	// Picks random color
	randomize();
	var val=irandom_range(0,8);
	var col=c_white;
	switch(val) {
		case 0:
			col=c_blue;
		break;
		case 1:
			col=c_green;
		break;
		case 2:
			col=c_red;
		break;
		case 3:
			col=c_yellow;
		break;
		case 4:
			col=c_orange;
		break;
		case 5:
			col=c_purple;
		break;
		case 6:
			col=c_olive;
		break;
		case 7:
			col=c_fuchsia;
		break;
		default: break;
	}
	// Creates lights at the mouse position
	var light=instance_create_depth(round(mouse_x),round(mouse_y),depth,o_light);
	light.color=col;
	light.str=-0.5; //-1 to 1
	light.size=500;
}

// Starts drawing vertices
vertex_begin(vb,vf);

var _vb=vb;
with(o_wallSolid) {
	quad(_vb,x,y,x+sprite_width,y+sprite_height);
	quad(_vb,x+sprite_width,y,x,y+sprite_height);
}
with(o_wallSolidRot) { // For rotating wall
	var diag=point_distance(x,y,x+sprite_width,y+sprite_height);
	var lenx=x+lengthdir_x(diag,image_angle-45);
	var leny=y+lengthdir_y(diag,image_angle-45);
	var horx=x+lengthdir_x(sprite_width,image_angle);
	var hory=y+lengthdir_y(sprite_width,image_angle);
	var verx=x+lengthdir_x(sprite_height,image_angle-90);
	var very=y+lengthdir_y(sprite_height,image_angle-90);
	quad(_vb,x,y,lenx,leny);
	quad(_vb,horx,hory,verx,very);
}
with(o_burnt) {
	quad(_vb,x,y,x+sprite_width,y+sprite_height);
	quad(_vb,x+sprite_width,y,x,y+sprite_height);
}
with(o_wallUR) {
	quad(_vb,x,y,x+sprite_width,y+sprite_height);
	quad(_vb,x,y+sprite_height,mid_x,mid_y);
}
/*with(o_player) {
	var px=x-4,py=y-10;
	quad(_vb,px-vx,py-vy,px+7-vx,py+14-vy);
	quad(_vb,px+7-vx,py-vy,px-vx,py+14-vy);
}*/

vertex_end(vb);