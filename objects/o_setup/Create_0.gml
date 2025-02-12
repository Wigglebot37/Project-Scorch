/// @desc Initialization & surfaces
// Setting shader variables
u_pos=shader_get_uniform(shd_light,"u_pos");
u_zz=shader_get_uniform(shd_light,"zz");
u_str=shader_get_uniform(shd_light,"u_str");
u_dir=shader_get_uniform(shd_light,"u_dir");
u_fov=shader_get_uniform(shd_light,"u_fov");
u_nmap=shader_get_sampler_index(shd_light,"u_nmap");

u_pos_shadow=shader_get_uniform(shd_shadow,"u_pos");

// Gets vertex setup for shadow shader
vertex_format_begin();
vertex_format_add_position_3d();
vf=vertex_format_end();
vb=vertex_create_buffer();

// Making it so alpha value of bckg cannot be affected
function BGbegin() {
	gpu_set_colorwriteenable(1,1,1,0);
}

// Resetting alpha writing back to original state
function BGend() {
	gpu_set_colorwriteenable(1,1,1,1);
}

// Gets background layer ids
var _bg_layer=layer_get_id("Background");
var _bg_layer2=layer_get_id("Background2");

// Runs script at beginning or end of specified layer, moving bottom to top in the list
layer_script_begin(_bg_layer,BGbegin);
layer_script_end(_bg_layer,BGend);

global.n_surf=noone;
var _n_layer=layer_get_id("Normal");
layer_set_visible(_n_layer,true);
var _n_layer2=layer_get_id("ObjectNorm");
layer_set_visible(_n_layer2,true);

globalvar guynorm;
if(instance_exists(o_player)) {
	guynorm=layer_sprite_create(_n_layer2,o_player.x,o_player.y,sp_guynorm);
}

function nbegin() {
	var vx=round(camera_get_view_x(view));
	var vy=round(camera_get_view_y(view));
	// Creates normal surface if it doesn't exist
	if(!surface_exists(global.n_surf)) {
		global.n_surf=surface_create(view_w,view_h);
	}
	// Sets normal surface as the target
	surface_set_target(global.n_surf);
	// Gets the id of the normal tilemap
	var tmap=layer_tilemap_get_id("Normal");
	
	if(instance_exists(o_player)) {
		layer_sprite_x(guynorm,round(o_player.x)-vx);
		layer_sprite_y(guynorm,round(o_player.y)-vy);
		layer_sprite_index(guynorm,o_player.image_index);
	}
	
	// Adjusts x and y values of tilemap to remain in place regardless of where the viewport moves
	tilemap_x(tmap,-vx);
	tilemap_y(tmap,-vy); 
	draw_clear_alpha(c_white,0);
}

function nend() {
	surface_reset_target();
}

// Applies scripts to run when drawing normal layer
layer_script_begin(_n_layer,nbegin);
layer_script_end(_n_layer2,nend);

//show_debug_overlay(1);