/// @desc Creates globals
#macro UP_LEFT 135
#macro UP 90
#macro UP_RIGHT 45
#macro RIGHT 0
#macro DOWN_RIGHT 315
#macro DOWN 270
#macro DOWN_LEFT 225
#macro LEFT 180
globalvar paused,debug,version;
paused=false; debug=false;
version="Pre-Alpha V09.22.23";

// Turns sprite into font
mapstring=" 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz.!?,'()&:;/%#\"$*+-=<>[]^_{}|\\~";
globalvar fnt_pixel,fnt_tiny;
fnt_pixel=font_add_sprite_ext(sp_fontbig,mapstring,true,3);
fnt_tiny=font_add_sprite_ext(sp_tinyfontbig,mapstring,true,3);
draw_set_font(fnt_tiny);

globalvar partSys,partSys2,pixel_surf;
partSys=part_system_create();
partSys2=part_system_create();

part_system_automatic_draw(partSys,false);
part_system_automatic_draw(partSys2,false);

pixel_surf=-1;

// Sets cursor to custom sprite
window_set_cursor(cr_none);
cursor_sprite=sp_cursor;

part_system_depth(partSys,0);
part_system_depth(partSys2,-1);

// Makes it so application surface must be drawn manually
application_surface_draw_enable(false);