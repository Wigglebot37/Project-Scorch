/// @desc Draws shaded surfaces
// Using local variables is easier for the computer
var _u_pos=u_pos;
var _u_pos2=u_pos_shadow;
var _u_str=u_str;
var _u_dir=u_dir;
var _u_fov=u_fov;
var _u_nmap=u_nmap;
var _u_zz=u_zz;
var _vb=vb;

var vw=view_w,vh=view_h;
var vx=round(camera_get_view_x(view));
var vy=round(camera_get_view_y(view));

// Creates lighting surface size of the view
if(!surface_exists(pixel_surf)) {
	pixel_surf=surface_create(vw,vh);
}

#region Normal Fix for Sprites
surface_set_target(global.n_surf);
// Uses unique shader to counteract normal map bleeding
shader_set(shd_norm);
with(o_player) {
	//draw_sprite(sprite_index,image_index,x-vx,y-vy);
	//draw_sprite(legsp,subleg,x-vx,y-vy);
	
	var _x=x-2,_y=1;
	if(flamedir>=90 && flamedir<270) {
		_x=x;
		_y=-1;
	}
	draw_sprite_ext(sp_guyhand,0,_x-vx,y-vy,1,1,flamedir,c_white,1);
	draw_sprite_ext(sp_flamethrower,0,_x-vx,y-vy,1,_y,flamedir,c_white,1);
	
	part_system_drawit(partSys);
	part_system_drawit(partSys2);
}
with(o_test) {
	draw_sprite(sprite_index,image_index,x-vx,y-vy);
}
shader_reset();
surface_reset_target();
#endregion

// Sets all x and y values to be drawn with the rounded camera position subtracted
matrix_set(matrix_world,matrix_build(-vx,-vy,0,0,0,0,1,1,1));

// Sets target to lighting surface
surface_set_target(pixel_surf);
draw_clear_alpha(c_black,0);
// Draws scaled application surface at low alpha to provide ambient lighting
draw_surface_ext(application_surface,vx,vy,vw/win_w,vh/win_h,0,c_white,0.3);
with(o_light) {
	#region Draws Shadows
	// LOOK UP TUTORIAL!!!
	gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_one);
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,x,y);
	// Submits vertex list of triangles
	vertex_submit(_vb,pr_trianglelist,-1);
	#endregion
	
	#region Draws lights
	// LOOK UP TUTORIAL!!!
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha,bm_one,bm_zero,bm_zero);
	shader_set(shd_light);
	// Sets light properties
	shader_set_uniform_f(_u_pos,x,y);
	shader_set_uniform_f(_u_zz,size);
	shader_set_uniform_f(_u_str,str);
	shader_set_uniform_f(_u_dir,dir);
	shader_set_uniform_f(_u_fov,fov);
	// Uses texture from normal map
	texture_set_stage(_u_nmap,surface_get_texture(global.n_surf));
	#endregion
	
	// Draws scaled application surface onto lighting surface w/ light color
	draw_surface_ext(application_surface,vx,vy,vw/win_w,vh/win_h,0,color,1);
}
shader_reset();
surface_reset_target();

// Resets matrix to original state
matrix_set(matrix_world,matrix_build(0,0,0,0,0,0,1,1,1));

gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
draw_surface(pixel_surf,vx,vy);

// Unrounded camera positions
var vx2=camera_get_view_x(view);
var vy2=camera_get_view_y(view);
// Draws borders to cover up rounding differences that cause glitchy effect on screen edge
draw_surface_part(pixel_surf,0,0,1,vh,vx2,vy); // left border
draw_surface_part(pixel_surf,0,0,vw,1,vx,vy2); // top border
draw_surface_part(pixel_surf,vw-1,0,1,vh,vx2+vw-1,vy); // right border
draw_surface_part(pixel_surf,0,vh-1,vw,1,vx,vy2+vh-1); // bottom border
gpu_set_blendmode(bm_normal);