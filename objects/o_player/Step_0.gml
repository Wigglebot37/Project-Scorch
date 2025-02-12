/// @desc Handles movement
if(!debug) {
	hsp=keyboard_check(ord("D"))-keyboard_check(ord("A"));
	var jmp=keyboard_check_pressed(vk_space);
	
	// Makes flamethrower follow mouse
	var _d=point_direction(x,y,mouse_x,mouse_y);
	_d=round(_d/45)*45;
	flamedir=approach360(flamedir,_d,5);
	_d=flamedir;
	
	// Applies direction for character to look in
	if(_d<30 || _d>330) image_index=0;
	else if(_d>=30 && _d<90) image_index=1;
	else if(_d>=90 && _d<140) image_index=4;
	else if(_d>=140 && _d<210) image_index=3;
	else if(_d>=210 && _d<270) image_index=5;
	else if(_d>=270 && _d<=330) image_index=2;
	
	// Draws legs depending on character looking dir
	if(image_index>2) legsp=sp_guylegslt;
	else legsp=sp_guylegsrt;
	
	// Sand physics
	if(place_meeting(x,y,o_sand)) {
		canJump=0;
		vsp=1;
	}
	
	// Checks if jump can occur
	if(canJump-->0 && jmp) {
		vsp=-vspJump;
		canJump=0;
	}
	
	#region Collision
	// Side wall collision
	if(place_meeting(x+hsp,y,o_wall)) hsp=0;
	x+=hsp;
	// Vertical wall collision
	if(vsp==0) vsp=1;
	if(place_meeting(x,y+vsp,o_wall)) {
		while(!place_meeting(x,y+sign(vsp)*1,o_wall)) y+=sign(vsp)*1;
		if(vsp>0) {
			fall=true;
			canJump=8;
		}
		vsp=0;
	}
	if(fall && !place_meeting(x,y+1,o_wall)) {
		vsp++;
		alarm[8]=4;
		fall=false;
	}
	// Limits top speed
	vsp=clamp(vsp,-4,4);
	y+=vsp;
	#endregion
		
	// For flame shooting
	if(mouse_check_button(mb_left)) {
		var _m=0,_a=0;
		if(_d>90 && _d<270) _m=10;
		else if(_d<90 || _d>270) _a=10;
		var _l=11;
		
		// Determines positioning for particles
		var _xx=x-2,_yy=y;
		if(flamedir>=90 && flamedir<270) {
			_xx=x+lengthdir_x(1,flamedir+90);
			_yy=y+lengthdir_y(1,flamedir+90);
		}
		
		// Changes flame/smoke direction
		part_type_direction(global.ptFlame,flamedir-5,flamedir+5,0,10);
		part_type_direction(global.ptSmoke,flamedir-(5+_m),flamedir+(5+_a),0,10);
		var _x=_xx+lengthdir_x(_l,flamedir),_y=_yy+lengthdir_y(_l,flamedir);
		
		var xx=x-2,bb=lengthdir_x(2,flamedir+90),cc=lengthdir_y(2,flamedir+90);
		if(flamedir>=90 && flamedir<270) {
			xx=x;
		}
		var adj=sqrt(2),_dd=wrapdir(flamedir-45);
		
		// Collision box coords
		a=xx+adj*dcos(_dd)+adj*dsin(_dd)+bb+lengthdir_x(10,flamedir);
		b=y+adj*dsin(_dd)+adj*dcos(_dd)+cc+lengthdir_y(10,flamedir);
		c=a+lengthdir_x(5,flamedir);
		d=b+lengthdir_y(5,flamedir);
		
		// Sends several collision boxes to determine how far flame should reach
		var _cl=0,i=0;
		for(i=0; i<12; i++) {
			_cl=collision_line_thick(a,b,c,d,3,o_surface);
			a=c;
			b=d;
			c=a+lengthdir_x(5,flamedir);
			d=b+lengthdir_y(5,flamedir);
			if(_cl!=noone) break;
		}
		// Scales flame/smoke according to wall collision
		var scale=sqrt(i)/4+0.12;
		if(i>0) {
			//Flame
			part_type_life(global.ptFlame,lerp(0,25,scale),lerp(0,30,scale));
			part_type_size(global.ptFlame,1,1.2,lerp(0,0.01,scale),0);
			part_type_speed(global.ptFlame,lerp(0,3,scale),lerp(0,3,scale),-lerp(0,0.05,scale),0);
		
			//Smoke
			part_type_life(global.ptSmoke,lerp(0,30,scale),lerp(0,40,scale));
			part_type_size(global.ptSmoke,0.4,0.4,lerp(0,0.05,scale),0);
			part_type_speed(global.ptSmoke,lerp(0,3,scale),lerp(0,3,scale),-lerp(0,0.06,scale),0);
		
			var vx=camera_get_view_x(view);
			var vy=camera_get_view_y(view);
			
			// Assigns particles to layered systems
			part_particles_create(partSys,_x-vx-hsp,_y-vy-vsp,global.ptSmoke,1);
			part_particles_create(partSys2,_x-vx-hsp,_y-vy-vsp,global.ptFlame,1);
			lightobj.x=_x-hsp;
			lightobj.y=_y-vsp;
			lightobj.size=5;
			
			if(_cl!=noone) {
				// Creates burnt sand top
				if(o_sandtop==_cl.object_index) {
					if(_cl.burntID==noone) {
						var binst=instance_create_layer(_cl.bbox_left,_cl.bbox_top,"Instances",o_burnt);
						binst.myID=binst;
						binst.topID=_cl;
						_cl.burntID=binst;
					}
				} else if(o_wood==_cl.object_index) {
					_cl.burning=true;
				}
			}
		}
	} else lightobj.size=-10;
	
	#region	Animates legs
	if(hsp!=0 && canJump>0) {
		if(!anim) {
			alarm[0]=8; // # of frames per second that the animation switches
			subleg=(subleg+1)%4;
			anim=true;
		}
	} else subleg=0;
	if(hsp==0) x=round(x);
	#endregion
}