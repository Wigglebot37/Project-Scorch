/// @function		parse_terminal(term_str);
/// @param term_str	String from terminal
/// @description	Parses string from terminal.
function parse_terminal(term_str) {
	if(string_char_at(term_str,0)!="/") return "null";
	
	var command="",command2="",pos=string_pos(" ",term_str),len=string_length(term_str);
	if(pos>2) {
		command=string_copy(term_str,2,pos-2);
		if(pos!=len) command2=string_copy(term_str,pos+1,len);
	}
	else if(pos==0) command=string_copy(term_str,2,len);
	else return "null";
	
	switch(command) {
		case "help":
			if(command2!="") return "poggers";
			else break;
		case "clear":
			if(command2=="") {
				clear_term();
				return "Terminal cleared";
			} else break;
		case "collision":
			if(command2=="") {
				var layerID=layer_get_id("Collision");
				layer_set_visible(layerID,!layer_get_visible(layerID));
				return "Visibility Changed";
			} else break;
		// add more commands here
		default: break;
	}
	return "null";
}