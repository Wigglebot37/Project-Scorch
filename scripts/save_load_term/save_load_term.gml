/// @function		save_term();
/// @param			term_str
/// @param			output
/// @description	Saves terminal content into file.
function save_term(term_str,output) {
	var sv_data=array_create(0);
	var sv_struct= {
		in: term_str,
		out: output,
	}
	if(file_exists("term0.dat")) {
		var buf=buffer_load("term0.dat");
		var str=buffer_read(buf,buffer_string);
		buffer_delete(buf);
		sv_data=json_parse(base64_decode(str));
	}
	array_insert(sv_data,0,sv_struct);
	if(array_length(sv_data)>8) array_resize(sv_data,8);
		
	var str=base64_encode(json_stringify(sv_data));
	var buf=buffer_create(string_byte_length(str)+1,buffer_fixed,1);
	buffer_write(buf,buffer_string,str);
	buffer_save(buf,"term0.dat");
	buffer_delete(buf);
	log("Data saved to file \"term0.dat\"");
}

/// @function		load_term();
/// @param			whole
/// @description	Loads terminal content from file.
function load_term(whole) {
	if(file_exists("term0.dat")) {
		var buf=buffer_load("term0.dat");
		var str=buffer_read(buf,buffer_string);
		buffer_delete(buf);
		var ld_data=json_parse(base64_decode(str));
		var ld_struct;
		
		while(array_length(ld_data)>0) {
			if(whole) ld_struct=array_pop(ld_data);
			else ld_struct=ld_data[0];
			array_push(input_arr,ld_struct.in);
			array_push(output_arr,ld_struct.out);
			if(!whole) exit;
		}
		
		log("Data loaded from file \"term0.dat\"");
	} else log("File \"term0.dat\" not found.");
}

/// @function		clear_term();
/// @description	Clears terminal.
function clear_term() {
	if(file_exists("term0.dat")) {
		array_delete(input_arr,0,array_length(input_arr));
		array_delete(output_arr,0,array_length(output_arr));
		file_delete("term0.dat");
		log("File \"term0.dat\" deleted.");
	} else log("File \"term0.dat\" not found.");
}