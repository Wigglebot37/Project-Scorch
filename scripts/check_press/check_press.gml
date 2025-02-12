/// @function		check_press();
/// @description	Checks all initial key presses.
function check_press() {
	var strLen=string_length(term_str);
	if(keyboard_check_pressed(vk_backspace)) {
		check=vk_backspace;
		term_str=string_delete(term_str,cursor_w,1);
		cursor_w--;
		strLen--;
	} else if(keyboard_check_pressed(vk_delete)) {
		check=vk_delete;
		term_str=string_delete(term_str,cursor_w+1,1);
		strLen--;
	} else if(keyboard_check_pressed(vk_left)) {
		check=vk_left;
		cursor_w--;
	} else if(keyboard_check_pressed(vk_right)) {
		check=vk_right;
		cursor_w++;
	}
	// If one of those was pressed, activate held check
	if(check!=vk_nokey) {
		typesubcount=0;
		held=true;
		alarm[0]=25;
	}
	return strLen;
}