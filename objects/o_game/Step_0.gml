/// @desc Save and load controls
if(!debug && !paused) {
	if(keyboard_check_pressed(ord("6"))) game_restart();
	else if(keyboard_check_pressed(ord("7"))) save_game();
	else if(keyboard_check_pressed(ord("8"))) load_game();
	else if(keyboard_check_pressed(ord("9"))) delete_save();
}