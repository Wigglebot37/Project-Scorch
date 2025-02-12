/// @desc Draws debug menu
if(debug) {
	var x_off=10;
	var y_off=3;
	// Draws colored rectangles for backgrounds
	draw_rectangle_sprite(sp_pixel,0,0,win_w,win_h*2/5,false,c_black,0.7);
	draw_rectangle_sprite(sp_pixel,0,win_h*2/5,win_w,win_h*9/20,false,c_dkgray,0.9);

	// Draws text
	draw_set_halign(fa_left);
	draw_set_font(fnt_tiny);
	if(term_str!="") draw_text_scribble(x_off,y_off+win_h*2/5,term_str);
	else {
		// Prompts user to type /help if nothing is written
		draw_set_color(c_gray);
		draw_text_scribble(x_off,y_off+win_h*2/5,"/help");
		draw_set_color(c_white);
	}
	// Draws blinking cursor
	draw_sprite(sp_typebar,typesub,string_width_scribble(string_copy(term_str,0,cursor_w))+4,(y_off*2)+win_h*2/5);
	
	// Draws list of stored previous commands
	var j=0;
	for(var i=array_length(input_arr)-1; i>=0; i--) {
		draw_text_scribble(x_off,y_off+floor(win_h*((7-j)/20)),input_arr[i]);
		draw_text_scribble(x_off+win_w*4/5,y_off+floor(win_h*((7-j)/20)),output_arr[i]);
		j++;
	}
} else {
	// Draws infohud if terminal is not pulled up
	if(infohud) {
		draw_set_halign(fa_right);
		draw_text_scribble(win_w-10,6,"FPS: "+string(fps));
		draw_text_scribble(win_w-10,30,version);
	}
}
/*
draw_set_font(fnt_pixel);
draw_text_scribble(400,300,"THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG");
draw_text_scribble(400,350,"the quick brown fox jumps over the lazy dog");
draw_text_scribble(400,400,"0,1.2(3)4/5'6%7#8:9;[[]{}<>!&-_+=^*$\"?/~");
*/