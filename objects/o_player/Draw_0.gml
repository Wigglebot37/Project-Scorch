/// @desc Draws player and flame
// Draws sprite and legs
draw_self();
draw_sprite(legsp,subleg,x,y)

// Calculates x and y positions depending on flamethrower angle
var _x=x-2,_y=1;
if(flamedir>=90 && flamedir<270) {
	_x=x;
	_y=-1;
}

var vx=round(camera_get_view_x(view));
var vy=round(camera_get_view_y(view));
if(!surface_exists(pixel_surf)) {
	pixel_surf=surface_create(view_w,view_h);
}

// Draws the scaled down surface for things that should stay pixelated
surface_set_target(pixel_surf);
// Clears surface
draw_clear_alpha(c_black,0);

// Draws rotated hand and flamethrower
draw_sprite_ext(sp_guyhand,0,_x-vx,y-vy,1,1,flamedir,c_white,1);
draw_sprite_ext(sp_flamethrower,0,_x-vx,y-vy,1,_y,flamedir,c_white,1);

/*draw_primitive_begin(pr_linestrip);
draw_vertex(_x-vx,y-vy);
draw_vertex(_x+20-vx,y-40-vy);
draw_vertex(_x-50-vx,y-30-vy);
draw_primitive_end();*/

// Draws flame and smoke particles scaled down to pixel form
part_system_drawit(partSys);
part_system_drawit(partSys2);
surface_reset_target();

// Draws scaled down pixelated surface
draw_surface(pixel_surf,vx,vy);