/// @desc Frees surfaces & particles
part_system_destroy(partSys);
part_system_destroy(partSys2);

if(surface_exists(o_pause.pause_surf)) surface_free(o_pause.pause_surf);
if(buffer_exists(o_pause.pause_surf_buffer)) buffer_delete(o_pause.pause_surf_buffer);
if(surface_exists(pixel_surf)) surface_free(pixel_surf);
if(surface_exists(global.n_surf)) surface_free(global.n_surf);