/// @desc Handling debug strings

// Triggers debug mode
if(keyboard_check_pressed(vk_f1) && !paused) {
	debug=!debug;
	keyboard_lastchar="";
}
// Triggers info hud
if(keyboard_check_pressed(vk_f2) && !debug) infohud=!infohud;
if(paused) exit;
if(debug) {
	// Grabs byte value of entered keyboard character
	var lastChar=string_byte_at(keyboard_lastchar,0);
	var strLen=string_length(term_str);
	if(strLen>0) {
		if(check==vk_nokey) strLen=check_press();
		if(keyboard_check(vk_backspace) && cooldown==0) {
			term_str=string_delete(term_str,cursor_w,1);
			cursor_w--;
			strLen--;
			cooldown=4;
		} else if(keyboard_check(vk_delete) && string_length(term_str)>cursor_w && cooldown==0) {
			term_str=string_delete(term_str,cursor_w+1,1);
			strLen--;
			cooldown=4;
		}
	}
	// Allows copying and pasting w/ clipboard
	if(keyboard_check(vk_control)) {
		if(keyboard_check_pressed(ord("C"))) clipboard_set_text(term_str);
		else if(keyboard_check_pressed(ord("V")) && clipboard_has_text()) {
			term_str=string_copy(clipboard_get_text(),1,60);
			strLen=string_length(term_str);
			cursor_w=strLen;
		}
	// Checks to see if character is valid and adds it to the string
	} else if(lastChar>=32 && lastChar<=126 && lastChar!=64 && lastChar!=96
	&& strLen<60) {
		term_str=string_insert(keyboard_lastchar,term_str,cursor_w+1);
		strLen++;
		cursor_w++;
		keyboard_lastchar="";
	}
	// Blinking cursor movement
	var replace=false,none=false;
	// Moves cursor between letters
	if(keyboard_check(vk_left) && cooldown==0) cursor_w--;
	else if(keyboard_check(vk_right) && cooldown==0) cursor_w++;
	// Retrieves previous memory
	else if(keyboard_check_pressed(vk_up)) {
		cursor_h++;
		replace=true;
	} else if(keyboard_check_pressed(vk_down)) {
		cursor_h--;
		replace=true;
	// Shifts cursor to beginning or end
	} else if(keyboard_check_pressed(vk_home)) cursor_w=0;
	else if(keyboard_check_pressed(vk_end)) cursor_w=strLen;
	else none=true;
	// If one of the above were pressed, resets cursor subimg
	if(!none) {
		typesubcount=0;
		cooldown=4;
	}
	
	var arrLen=array_length(input_arr);
	cursor_w=clamp(cursor_w,0,strLen);
	if(cursor_h>arrLen) cursor_h=0;
	else if(cursor_h<0) cursor_h=arrLen;
	
	// For when cursor is in the middle of a command
	if(replace) {
		if(cursor_h==0) term_str="";
		else term_str=input_arr[arrLen-cursor_h];
		cursor_w=string_length(term_str);
	}
	
	// Handles entered commands
	if(keyboard_check_pressed(vk_enter) && term_str!="") {
		// Parses command
		output=parse_terminal(term_str);
		// Checks if terminal is being cleared or not
		if(output!="Terminal cleared") save_term(term_str,output);
		load_term(false);
		// Deletes oldest entry if full
		if(array_length(input_arr)>8) {
			array_delete(input_arr,0,1);
			array_delete(output_arr,0,1);
		}
		cursor_h=0;
		output="";
		term_str="";
	}
	// Progresses blinking cursor subimg
	if(check!=vk_nokey) {
		if(!keyboard_check(check)) {
			held=false;
			keylock=true;
			check=vk_nokey;
		}
	}
	// If a specific type of key isn't being held, let the cursor blink
	if(!held) typesubcount++;
	// loop every 60 frames
	if(typesubcount>60) typesubcount=0;
	// blink off and on for half a second each
	if(typesubcount>30) typesub=1;
	else typesub=0;
	// Activates after initial holding phase
	if(!keylock) cooldown--;
	else cooldown=4;
	if(cooldown<0) cooldown=0;
}